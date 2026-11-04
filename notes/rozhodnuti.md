# Rozhodnutí

Záznam rozhodnutí o struktuře práce a repa. Nové rozhodnutí přidej nahoru: datum, co, proč.

## 2026-11-04 – Výchozí struktura (vedoucí práce)

Dohodnuto na úvodní konzultaci vedoucího s AI agentem (Claude Code). Výchozím bodem byla první osnova studenta (`osnova-bakalarske-prace.md` v historii gitu).

**Repo a nástroje**

- Text je v Markdownu, jeden soubor na kapitolu. Důvod: strojová čitelnost pro AI agenty, diffy v PR a čtení na GitHubu bez sestavení.
- Výstup je PDF/A přes Pandoc a **LaTeX repliku povinné šablony FMT**. Oficiální šablona existuje jen ve Wordu; replika je proměřená podle ní (`tools/latex/fmt-thesis.cls`). Vedoucí si ověří u fakulty, že replika vyhovuje. Záložní cestou je Pandoc → DOCX s oficiální šablonou.
- Citace se zpracují přes Pandoc citeproc a CSL ISO 690 (číselný styl, hranaté závorky). Tím zůstává otevřená cesta k DOCX.
- Fonty Calibri a Cambria Math jsou v repu, aby výsledek odpovídal šabloně přesně.
- Literatura (PDF) je commitovaná v repu, aby se citáty daly ověřit. Repo se případně přepne na soukromé.
- Ověřitelnost: každá citace má lokátor a k němu doslovný citát v `literature/<klíč>.md`; `make check` citát hledá v PDF.
- AI smí psát text i kód. Pravidla VŠB-TUO o AI jsou doporučení; agent na možný rozpor upozorní, ale neblokuje. Klíčová je transparentnost (`notes/ai-log.md`).
- CI (GitHub Actions) sestaví PDF při každém push a PR.

**Osnova (změny oproti první verzi studenta)**

- Pořadí kapitol podle šablony FMT: Úvod → Analýza současného stavu → Cíle → Volba technologií. Kritéria volby technologií tak vycházejí z cílů.
- Nově podkapitola **Mezičásticové interakce** (van der Waals → Hamaker), protože Hamakerův model je v názvu práce.
- Lyofilizace postavená na literatuře k **řízené vakuové sublimaci nanodisperzí** (Dvorský, Krpelík) místo farmaceutické lyofilizace; navázání na práce Fenclové (2014) a Horáčkové (2016).
- Cíle a požadavky formulované **technologicky neutrálně** + explicitní ne-cíle.
- Nově **základy 3D vizualizace** a **jednotky a škálování**.
- Volba technologií jako **vážená rozhodovací matice** se třemi osami (výpočet, vizualizace a GUI, přenos), výhledem škálování k $10^6$ částic a kritériem vhodnosti pro AI-asistovaný vývoj. Matice je bez předvyplněných bodů; návrh vedoucího (C++ + WebUI + Three.js) je jeden z kandidátů.
- Rozsah kapitol je jen doporučení; podmínkou je formální minimum FMT (35 stran).
- Praktická část (kapitola 5 a dál) se domluví zvlášť.
