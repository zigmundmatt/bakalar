# Vizualizace částicové dynamiky v Hamakerově modelu interakce

Bakalářská práce, Fakulta materiálově-technologická VŠB-TUO, 2026/2027.

Text se píše v Markdownu (`thesis/`) a sestavuje se do PDF/A ve vzhledu povinné šablony FMT. Na GitHubu se dá číst a komentovat přímo, bez sestavení.

- **Co a jak psát:** [`docs/osnova.md`](docs/osnova.md)
- **Pravidla pro lidi i AI agenty:** [`AGENTS.md`](AGENTS.md)
- **Proč je repo uspořádané takhle:** [`notes/rozhodnuti.md`](notes/rozhodnuti.md)

## Sestavení PDF

```sh
make pdf      # build/prace.pdf
make check    # kontrola citací a formálních požadavků (během psaní jen upozorňuje)
make final    # před odevzdáním: PDF + přísná kontrola
```

GitHub Actions sestaví PDF při každém push a pull requestu. Najdeš ho v záložce **Actions** → poslední běh → **Artifacts** → `prace-pdf`.

### Lokální instalace

| Nástroj | Verze | Poznámka |
|---|---|---|
| [Pandoc](https://github.com/jgm/pandoc/releases) | 3.11+ | ověřeno s 3.11 (Arch `pandoc-cli`) a 3.12.1 (CI) |
| [pandoc-crossref](https://github.com/lierdakil/pandoc-crossref/releases) | 0.3.20+ | musí být sestavený pro stejnou verzi Pandocu (Arch `pandoc-crossref`) |
| TeX Live | 2025+ | LuaLaTeX; na Arch Linuxu balíky `texlive-basic texlive-latex texlive-latexrecommended texlive-latexextra texlive-luatex texlive-fontsrecommended texlive-langczechslovak texlive-pictures` |
| poppler-utils | | `pdftotext`, `pdfinfo` pro kontrolu citátů |
| Python | 3.10+ | `tools/check.py`, jen standardní knihovna |

Fonty Calibri a Cambria Math jsou v `tools/latex/fonts/`. Když chybí, build použije náhradní fonty a upozorní, že takové PDF se nesmí odevzdat.

## Literatura a Zotero

Doporučené je Zotero s doplňkem [Better BibTeX](https://retorque.re/zotero-better-bibtex/):

1. Citation key formula nastav na `auth.lower + year`.
2. Kolekci s literaturou exportuj jako *Better BibLaTeX* se zapnutým **Keep updated** do `thesis/references.bib`.
3. PDF každého zdroje ulož do `literature/<klíč>.pdf` a poznámky s doslovnými citáty do `literature/<klíč>.md` (vzor je v `literature/_sablona.md`).
