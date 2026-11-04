# Build of the bachelor thesis.
#   make pdf     -> build/prace.pdf (PDF/A-2b, FMT template replica)
#   make check   -> citation and formal checks (warnings while drafting)
#   make final   -> pdf + strict checks for submission
#   make clean
#
# Requirements: pandoc >= 3.12, pandoc-crossref (built for the same pandoc),
# LuaLaTeX (TeX Live 2025+), poppler-utils (pdftotext, pdfinfo), python3.

CHAPTERS := $(sort $(wildcard thesis/[0-9][0-9]-*.md))
BUILD    := build
TEX      := $(BUILD)/prace.tex
PDF      := $(BUILD)/prace.pdf
LATEX    := lualatex -interaction=nonstopmode -halt-on-error -file-line-error \
            -output-directory=$(BUILD)
DEPS     := $(CHAPTERS) thesis/metadata.yaml thesis/references.bib \
            $(wildcard thesis/figures/*) $(wildcard tools/latex/*) \
            $(wildcard tools/pandoc/*) tools/csl/iso690-numeric-brackets-cs.csl

.PHONY: pdf tex check final pdfa clean

pdf: $(PDF)

tex: $(TEX)

$(TEX): $(DEPS)
	@mkdir -p $(BUILD)
	pandoc --defaults=tools/pandoc/defaults.yaml $(CHAPTERS) -o $@

$(PDF): $(TEX)
	TEXINPUTS=tools/latex//: $(LATEX) $(TEX) > $(BUILD)/latex-1.log || (tail -40 $(BUILD)/prace.log; exit 1)
	TEXINPUTS=tools/latex//: $(LATEX) $(TEX) > $(BUILD)/latex-2.log || (tail -40 $(BUILD)/prace.log; exit 1)
	TEXINPUTS=tools/latex//: $(LATEX) $(TEX) > $(BUILD)/latex-3.log || (tail -40 $(BUILD)/prace.log; exit 1)
	@grep -E "fmt-thesis Warning|Overfull|Undefined|undefined" $(BUILD)/prace.log | sort -u || true
	@echo "OK: $(PDF) ($$(pdfinfo $(PDF) | awk '/^Pages/ {print $$2}') stran PDF)"

check:
	python3 tools/check.py

final: pdf
	python3 tools/check.py --final --pdf $(PDF)

# PDF/A-2b validation with veraPDF (needs Docker; CI runs it on every push)
pdfa: pdf
	docker run --rm -v "$(CURDIR)/build:/data" verapdf/cli:v1.30.2 \
	  --flavour 2b --format text --verbose /data/prace.pdf

clean:
	rm -rf $(BUILD)
