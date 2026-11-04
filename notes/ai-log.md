# Záznam práce s AI

Transparentní záznam použití AI nástrojů (pravidla VŠB-TUO TUO_LEG_24_002, čl. 4 odst. 2 a čl. 6 odst. 1). Nový záznam přidej nahoru. Stačí pár řádků, ale vždy s ověřením.

Šablona záznamu:

```markdown
## RRRR-MM-DD – krátký název

- **Kdo / nástroj / model:** student + Claude Code (Claude Opus 5.5) …
- **Zadání (shrnutí promptu):** …
- **Výsledek:** které soubory a sekce vznikly nebo se změnily
- **Ověření:** make check bez chyb citací; ručně ověřeny citáty X, Y; …
```

## 2026-11-04 – Kontrola repliky šablony (vedoucí práce)

- **Kdo / nástroj / model:** vedoucí práce + Claude Code (Claude Opus 5.5)
- **Zadání (shrnutí promptu):** ukázat, jak se replika liší od šablony FMT při běžném pohledu; agent do pravidel o AI nemá vstupovat.
- **Výsledek:** tabulky v mřížce podle šablony, užší mezera za „Obr. 1“ a „Tab. 1“, mezery u obrázků a seznamů podle šablony, oprava chybějícího seznamu obrázků při čistém sestavení a číslování tabulek; `AGENTS.md` bez upozorňování na pravidla.
- **Ověření:** vzorová stránka šablony (obrázek, tabulka, rovnice) vysázená replikou a proměřená proti originálu; `make pdf` od nuly, `make check`.

## 2026-11-04 – Kostra repa a osnova (vedoucí práce)

- **Kdo / nástroj / model:** vedoucí práce + Claude Code (Claude Opus 5.5)
- **Zadání (shrnutí promptu):** z první osnovy studenta, zadání práce a startovních materiálů navrhnout strukturu repa pro lidi i AI agenty, sjednotit teoretickou část (kapitoly 1–4) a připravit sestavení do PDF/A podle šablony FMT. Rozhodnutí padla v řízeném rozhovoru, v němž agent kladl otázky a vedoucí rozhodoval.
- **Výsledek:** `docs/osnova.md`, `AGENTS.md`, kostra `thesis/`, LaTeX replika šablony `tools/latex/`, kontrola citací `tools/check.py`, CI.
- **Ověření:** replika proměřena proti oficiální šabloně vyrenderované se stejnými fonty; `make check` ověřen negativním testem (upravený citát a neexistující lokátor jsou zachyceny).
