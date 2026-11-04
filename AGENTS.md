# AGENTS.md

Repo bakalářské práce **„Vizualizace částicové dynamiky v Hamakerově modelu interakce“** (FMT VŠB-TUO, 2026/2027). Obsahuje text práce v Markdownu, její sestavení do PDF/A podle šablony FMT, literaturu a (později) kód prototypu.

Vedoucí práci pojímá jako ukázku toho, že **dobře řízený AI agent je invenční nástroj**: student, který umí agenta přesně zadat, ověřovat a vést, dosáhne výsledku, na který dřív bylo potřeba diplomanta. Agent tu proto smí psát text i kód. Hodnota práce stojí na tom, že každé tvrzení je **ověřitelné** a že je postup s AI **transparentně zdokumentovaný**.

## Kde co je

| Cesta | Obsah |
|---|---|
| `docs/osnova.md` | **Zadání každé kapitoly** (cíl, klíčové body, zdroje, rozsah, co tam nepatří). Přečti příslušnou sekci, než začneš psát nebo revidovat kapitolu. |
| `thesis/NN-*.md` | Text práce, jeden soubor na kapitolu; pořadí určuje číslo v názvu. |
| `thesis/metadata.yaml` | Titulní strana, bibliografický záznam, abstrakty, seznam zkratek a symbolů. |
| `thesis/references.bib` | Bibliografie (BibLaTeX, klíč `prijmeni + rok`, pole `langid`). |
| `literature/<klíč>.pdf`, `literature/<klíč>.md` | Zdroj a poznámka s doslovnými citáty; vzor je `literature/_sablona.md`. |
| `docs/predpisy/` | Zásady FMT, oficiální Word šablona, pravidla VŠB-TUO pro AI (TUO_LEG_24_002). |
| `notes/` | Rozhodnutí (`rozhodnuti.md`), záznam práce s AI (`ai-log.md`), zápisy ze schůzek. |
| `tools/` | Sestavení PDF (LaTeX replika šablony, Pandoc filtry, CSL styl) a kontroly. Uprav jen na výslovný požadavek. |
| `app/` | Prototyp (praktická část, zatím prázdné). |

Příkazy jsou v `Makefile` (`make pdf`, `make check`, `make final`).

## Postup při psaní kapitoly

1. Přečti sekci kapitoly v `docs/osnova.md` a zdroje, které uvádí.
2. Ke každému faktickému tvrzení najdi místo ve zdroji a zapiš ho do `literature/<klíč>.md` jako **doslovný citát** pod nadpis s **lokátorem**.
3. Napiš text do `thesis/NN-*.md` s citacemi s lokátorem.
4. Spusť `make check` a oprav všechna upozornění, která se týkají citací. Upozornění na počet zdrojů a stran smí během psaní zůstat.
5. Spusť `make pdf` a zkontroluj výsledek v `build/prace.pdf`.
6. Zapiš do `notes/ai-log.md`, co jsi jako agent udělal (viz Transparentnost).

Kapitola je hotová, když pokrývá všechny klíčové body z osnovy, `make check` nehlásí žádný problém s citacemi a PDF se sestaví bez chyb.

## Citace a ověřitelnost

Každé faktické tvrzení, vzorec, číselná hodnota a převzatý obrázek má citaci **s lokátorem**: `[@hamaker1937, s. 1060]`, `[@allen2017, kap. 1.5]`, více zdrojů `[@a, s. 3; @b, s. 7]`.

Pro každý použitý lokátor obsahuje `literature/<klíč>.md` nadpis `## s. 1060` a pod ním **doslovný citát** v původním jazyce, zkopírovaný ze zdroje beze změn (řádky začínající `>`), a řádek „Použito:“, který říká, kde a k čemu se citát v práci používá. `make check` hledá citát doslovně v `literature/<klíč>.pdf`. Citát, který tam nenajde, je chyba – buď je přepsaný, nebo je špatně zvolený zdroj.

Zdroj se do `references.bib` přidává až po ověření, že existuje a údaje sedí (DOI, ISBN, vydání). Primární zdroj má přednost před sekundárním. Vzorec cituj tam, kde byl odvozen, a ověř ho tam.

Literaturu do repa commituj včetně PDF (`literature/<klíč>.pdf`), aby kontrola i vedoucí mohli citáty ověřit.

## Psaní v Markdownu

- Jazyk práce je čeština. Uvozovky piš přímo „takto“. Nezlomitelné mezery po jednopísmenných předložkách doplní build sám.
- Odkazy uvnitř práce: nadpis `{#sec:nazev}`, rovnice `$$ … $$ {#eq:nazev}`, obrázek `![Popisek, zdroj: …](figures/soubor.png){#fig:nazev width=80%}`, tabulka s popiskem `: Popisek {#tbl:nazev}`. V textu se na ně odkazuje `[@sec:nazev]`, `[@eq:nazev]`, `[@fig:nazev]` a `[@tbl:nazev]`.
- Pod každou rovnicí následuje blok „Kde:“ se všemi nově zavedenými symboly ve tvaru `symbol – význam [jednotka]`:

  ```markdown
  ::: kde
  - $A$ – Hamakerova konstanta [J]
  :::
  ```

- Zkratky a symboly, jejichž význam není obecně známý, patří do `symbols` v `thesis/metadata.yaml`.
- Poznámky pro sebe a pro agenta piš jako HTML komentáře `<!-- … -->`. Do PDF se nedostanou.
- Ukázka všech prvků je v `thesis/01-uvod.md` (blok „UKÁZKA FORMÁTU“).

## Formální požadavky FMT

Zdroj: `docs/predpisy/FMT_Zasady_bakalarske_prace_2026_2027.pdf`.

- Rozsah alespoň **35 stran** od Obsahu (strana 1) včetně seznamu literatury.
- Alespoň **10 citovaných zdrojů**, z toho alespoň **3 ve světovém jazyce**. Každý zdroj v seznamu je citovaný v textu (seznam se generuje jen z citací).
- Citace podle ČSN ISO 690, číselné odkazy v hranatých závorkách. Vzorce jsou číslované v kulatých závorkách.
- Jednotná šablona FMT je povinná; v tomto repu ji zajišťuje `tools/latex/`.
- Odevzdává se PDF/A do 20 MB, název souboru `rok_login_BP.pdf` bez diakritiky.

`make final` ověří rozsah, počet zdrojů a citace přísně a hotová práce ho musí projít bez chyby.

## Transparentnost práce s AI

Pravidla VŠB-TUO (`docs/predpisy/TUO_LEG_24_002_B_pravidla_AI_VSB-TUO.pdf`) ber jako **doporučení**, ne jako kritérium přijetí. Vyžadují hlavně **transparentnost**: použití AI uvést včetně rozsahu (čl. 4 odst. 2), dokumentovat nástroje a prompty (čl. 6 odst. 1) a ověřovat fakta v primárních zdrojích (čl. 6 odst. 2).

- Po každé práci na textu nebo kódu přidej do `notes/ai-log.md` záznam: datum, nástroj a model, čeho se zadání týkalo (shrnutí promptu), co vzniklo a jak se to ověřilo.
- Když požadavek může být v rozporu s pravidly (např. čl. 5 odst. 2 – automatické psaní kvalifikační práce), **upozorni na to jednou větou a pokračuj**. Rozhodnutí a odpovědnost za obsah má student.
- Z `notes/ai-log.md` vznikne v praktické části kapitola o metodice práce s AI a příloha.
