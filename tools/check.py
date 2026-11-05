#!/usr/bin/env python3
"""Citation and formal checks for the thesis.

Checks (see AGENTS.md, section "Citace a ověřitelnost"):

1. Every citation key used in thesis/*.md exists in thesis/references.bib.
2. Every cited key has a note file literature/<key>.md.
3. Every citation has a locator (e.g. [@key, s. 12]).
4. Every locator used in the text has a matching heading "## <locator>"
   in the note file, followed by at least one verbatim quote ("> ...").
5. If the source PDF is in literature/, each quote is searched for in the
   PDF text (whitespace-insensitive); quotes that are not found are reported.

Formal FMT requirements (rules for AY 2026/2027, section II):

6. At least 10 cited sources, at least 3 of them in a world language
   (langid other than czech/slovak).
7. With --pdf: at least 35 pages counted from "Obsah" (page 1) to the end.

While drafting, everything is reported as a warning and the exit code is 0.
With --final, any problem makes the exit code 1.

Usage:
    python3 tools/check.py [--final] [--pdf build/prace.pdf]
"""

from __future__ import annotations

import argparse
import re
import shutil
import subprocess
import sys
import unicodedata
from dataclasses import dataclass, field
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
THESIS = ROOT / "thesis"
LITERATURE = ROOT / "literature"
BIB = THESIS / "references.bib"

MIN_SOURCES = 10
MIN_FOREIGN_SOURCES = 3
MIN_PAGES = 35
LOCAL_LANGS = {"czech", "slovak", "cs", "sk"}

# [@key], [@key, s. 12], [@a, s. 1; @b, kap. 2] and bare @key in text.
# Cross-references (@fig:, @eq:, @tbl:, @sec:) are not citations.
CITATION_GROUP = re.compile(r"\[([^\[\]]*@[^\[\]]+)\]")
CITATION_ITEM = re.compile(r"-?@([A-Za-z0-9_][\w:.#$%&+?<>~/-]*)\s*(?:,\s*([^;]+))?")
CROSSREF_PREFIXES = ("fig:", "eq:", "tbl:", "sec:", "lst:")
HTML_COMMENT = re.compile(r"<!--.*?-->", re.S)
BIB_ENTRY = re.compile(r"@(\w+)\s*\{\s*([^,\s]+)\s*,(.*?)\n\}", re.S)
BIB_LANGID = re.compile(r"\blangid\s*=\s*\{([^}]*)\}", re.I)


@dataclass
class Report:
    problems: list[str] = field(default_factory=list)
    notes: list[str] = field(default_factory=list)

    def problem(self, message: str) -> None:
        self.problems.append(message)

    def note(self, message: str) -> None:
        self.notes.append(message)


def normalize_locator(locator: str) -> str:
    """'s.12', 's. 12', 'S. 12' -> 's. 12'; dashes unified to an en dash."""
    loc = locator.strip().rstrip(".")
    loc = re.sub(r"[‐-‒—―-]", "–", loc)
    loc = re.sub(r"\s*–\s*", "–", loc)
    loc = re.sub(r"^(s|kap|rov|obr|tab|p|pp|ch|sec)\.?\s*", lambda m: m.group(1).lower() + ". ", loc, flags=re.I)
    return re.sub(r"\s+", " ", loc)


def normalize_text(text: str) -> str:
    """For quote matching: NFKC (splits ligatures), drop hyphenation, collapse spaces."""
    text = unicodedata.normalize("NFKC", text)
    text = re.sub(r"-\s*\n\s*", "", text)
    text = re.sub(r"\s+", "", text)
    return text.lower()


def read_bib() -> dict[str, str]:
    """key -> langid ('' if missing)."""
    entries: dict[str, str] = {}
    if not BIB.exists():
        return entries
    for _type, key, body in BIB_ENTRY.findall(BIB.read_text(encoding="utf-8")):
        langid = BIB_LANGID.search(body)
        entries[key] = langid.group(1).strip().lower() if langid else ""
    return entries


def find_citations() -> list[tuple[Path, int, str, str | None]]:
    """(file, line, key, locator) for each citation in the thesis chapters."""
    found = []
    for md in sorted(THESIS.glob("[0-9][0-9]-*.md")):
        text = HTML_COMMENT.sub(lambda m: "\n" * m.group(0).count("\n"), md.read_text(encoding="utf-8"))
        for match in CITATION_GROUP.finditer(text):
            line = text.count("\n", 0, match.start()) + 1
            for item in match.group(1).split(";"):
                cite = CITATION_ITEM.search(item)
                if not cite:
                    continue
                key, locator = cite.group(1), cite.group(2)
                if key.startswith(CROSSREF_PREFIXES):
                    continue
                found.append((md, line, key, locator.strip() if locator else None))
    return found


def parse_note(note: Path) -> dict[str, list[str]]:
    """locator heading -> list of verbatim quotes under it."""
    sections: dict[str, list[str]] = {}
    current: str | None = None
    quote_lines: list[str] = []

    def flush() -> None:
        if current is not None and quote_lines:
            sections.setdefault(current, []).append(" ".join(quote_lines))

    for raw in note.read_text(encoding="utf-8").splitlines():
        heading = re.match(r"^##\s+(.+?)\s*$", raw)
        if heading:
            flush()
            quote_lines = []
            current = normalize_locator(heading.group(1))
            sections.setdefault(current, [])
            continue
        if raw.startswith(">"):
            quote_lines.append(raw.lstrip(">").strip())
        else:
            flush()
            quote_lines = []
    flush()
    return sections


def pdf_text(pdf: Path) -> str | None:
    if not shutil.which("pdftotext"):
        return None
    result = subprocess.run(["pdftotext", "-q", str(pdf), "-"], capture_output=True, text=True)
    return result.stdout if result.returncode == 0 else None


def numbered_pages(pdf: Path) -> int | None:
    """Pages from 'Obsah' (page 1) to the end, read from the PDF page labels."""
    try:
        import pymupdf  # type: ignore
    except ImportError:
        pymupdf = None
    if pymupdf is not None:
        doc = pymupdf.open(pdf)
        labels = [doc[i].get_label() for i in range(doc.page_count)]
        if "1" in labels:
            return doc.page_count - labels.index("1")
    if shutil.which("pdftotext") and shutil.which("pdfinfo"):
        info = subprocess.run(["pdfinfo", str(pdf)], capture_output=True, text=True).stdout
        total = int(re.search(r"Pages:\s+(\d+)", info).group(1))
        for page in range(1, total + 1):
            text = subprocess.run(["pdftotext", "-q", "-f", str(page), "-l", str(page), str(pdf), "-"],
                                  capture_output=True, text=True).stdout
            if re.match(r"\s*Obsah\b", text):
                return total - page + 1
    return None


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--final", action="store_true", help="strict mode for submission")
    parser.add_argument("--pdf", type=Path, help="built thesis PDF for the page count check")
    args = parser.parse_args()

    report = Report()
    bib = read_bib()
    citations = find_citations()
    cited_keys = sorted({key for _, _, key, _ in citations})
    pdf_cache: dict[str, str | None] = {}

    for md, line, key, locator in citations:
        where = f"{md.relative_to(ROOT)}:{line}"
        if key not in bib:
            report.problem(f"{where}: klíč @{key} není v thesis/references.bib")
        note = LITERATURE / f"{key}.md"
        if not note.exists():
            report.problem(f"{where}: chybí poznámka literature/{key}.md s doslovnými citáty")
            continue
        if not locator:
            report.problem(f"{where}: citace @{key} nemá lokátor (např. [@{key}, s. 12])")
            continue
        sections = parse_note(note)
        loc = normalize_locator(locator)
        if loc not in sections:
            report.problem(f"{where}: v literature/{key}.md chybí nadpis „## {loc}“ s citátem")
            continue
        if not sections[loc]:
            report.problem(f"{where}: pod „## {loc}“ v literature/{key}.md není doslovný citát (řádek začínající „>“)")
            continue
        pdf = LITERATURE / f"{key}.pdf"
        if not pdf.exists():
            report.note(f"literature/{key}.pdf chybí – citát u „{loc}“ nelze ověřit automaticky")
            continue
        if key not in pdf_cache:
            text = pdf_text(pdf)
            pdf_cache[key] = normalize_text(text) if text else None
        haystack = pdf_cache[key]
        if haystack is None:
            report.note(f"literature/{key}.pdf: text nelze přečíst (chybí pdftotext nebo jde o sken)")
            continue
        for quote in sections[loc]:
            if normalize_text(quote) not in haystack:
                report.problem(f"literature/{key}.md „## {loc}“: citát nebyl v PDF nalezen doslovně: „{quote[:70]}…“")

    foreign = [k for k in cited_keys if k in bib and bib[k] and bib[k] not in LOCAL_LANGS]
    missing_lang = [k for k in cited_keys if k in bib and not bib[k]]
    for key in missing_lang:
        report.problem(f"thesis/references.bib: záznam {key} nemá pole langid")
    if len(cited_keys) < MIN_SOURCES:
        report.problem(f"FMT: citováno {len(cited_keys)} zdrojů, požadováno alespoň {MIN_SOURCES}")
    if len(foreign) < MIN_FOREIGN_SOURCES:
        report.problem(f"FMT: citováno {len(foreign)} cizojazyčných zdrojů, požadováno alespoň {MIN_FOREIGN_SOURCES}")

    if args.pdf:
        if not args.pdf.exists():
            report.problem(f"{args.pdf} neexistuje – nejdřív spusťte make pdf")
        else:
            pages = numbered_pages(args.pdf)
            if pages is None:
                report.note("počet stran nelze zjistit (chybí PyMuPDF i poppler-utils)")
            elif pages < MIN_PAGES:
                report.problem(f"FMT: práce má {pages} stran od Obsahu, požadováno alespoň {MIN_PAGES}")
            else:
                report.note(f"rozsah: {pages} stran od Obsahu (minimum {MIN_PAGES})")

    label = "CHYBA" if args.final else "upozornění"
    for message in report.problems:
        print(f"[{label}] {message}")
    for message in report.notes:
        print(f"[info] {message}")
    print(f"Citací: {len(citations)}, zdrojů: {len(cited_keys)} (cizojazyčných {len(foreign)}), "
          f"problémů: {len(report.problems)}")
    return 1 if (args.final and report.problems) else 0


if __name__ == "__main__":
    sys.exit(main())
