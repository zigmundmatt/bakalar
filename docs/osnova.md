# Osnova bakalářské práce – živá specifikace

**Název:** Vizualizace částicové dynamiky v Hamakerově modelu interakce
**Fakulta:** FMT VŠB-TUO, akademický rok 2026/2027
**Stav:** dohodnuta kapitola 1–4 (teoretická část a volba technologií); praktická část (kapitola 5 a dál) se domlouvá zvlášť.

Tento dokument je **zadání pro psaní** jednotlivých kapitol – pro tebe i pro AI agenta. U každé (pod)kapitoly najdeš:

- **Cíl** – co má čtenář po přečtení vědět nebo umět posoudit.
- **Klíčové body** – co tam musí zaznít (pořadí je doporučené, ne závazné).
- **Zdroje** – citační klíče z `thesis/references.bib`; „doplnit“ znamená, že zdroj je potřeba dohledat a přidat.
- **Rozsah** – doporučení vedoucího, ne podmínka přijetí. Jdi do hloubky, kam tě téma vede.
- **Nepatří sem** – aby se kapitoly nepřekrývaly a práce se nerozlézala.
- **Vazby** – na co kapitola navazuje a co z ní používají další kapitoly.

Když se během psaní ukáže, že osnova nesedí, **uprav nejdřív tento soubor** (a krátce to zapiš do `notes/rozhodnuti.md`), teprve potom text kapitoly. Osnova a text se nesmí rozejít.

## Celkový rámec

Zadání (EDISON) žádá navrhnout a implementovat **prototyp softwarového nástroje pro interaktivní 3D vizualizaci částicové dynamiky v konečném periodickém boxu**. Fyzikální motivací je agregace nanočástic při řízené vakuové lyofilizaci a Hamakerův model interakce, **těžiště práce je však v softwarové architektuře, reprezentaci částicového systému, základním časovém vývoji a 3D vizualizaci**.

Z toho plyne tón celé teoretické části: fyziku a numeriku vykládej **v hloubce, kterou potřebuje návrh softwaru**. U každého fyzikálního nebo numerického tématu si polož otázku *„Co z toho plyne pro program?“* a odpověď napiš. Příklad: strmost Hamakerova potenciálu při malé vzdálenosti → nutnost malého časového kroku a ošetření kontaktu → požadavek na oddělení simulačního kroku od vykreslování.

Pořadí kapitol odpovídá doporučenému členění šablony FMT: Úvod → Analýza současného stavu poznání → Cíle → vlastní řešení → Diskuse → Závěr. Kritéria pro volbu technologií (kapitola 4) se proto odvozují z cílů a požadavků (kapitola 3), které stojí těsně před nimi.

| Kapitola | Soubor | Doporučený rozsah |
|---|---|---|
| 1 Úvod | `thesis/01-uvod.md` | 1,5–2 s. |
| 2 Analýza současného stavu poznání | `thesis/02-analyza-soucasneho-stavu.md` | 13–16 s. |
| 3 Cíle a požadavky | `thesis/03-cile-a-pozadavky.md` | 2–3 s. |
| 4 Volba technologií | `thesis/04-volba-technologii.md` | 4–6 s. |
| 5–7 Praktická část | domluví se | – |
| Diskuse, Závěr | `thesis/80-diskuse.md`, `thesis/85-zaver.md` | – |

Formální minimum FMT je 35 stran od Obsahu včetně seznamu literatury (viz `AGENTS.md`).

---

## Kapitola 1 – Úvod

**Cíl:** Čtenář ví, proč téma vzniklo, co přesně práce dělá a co nedělá a jak je text uspořádaný.

**Klíčové body:**

1. Motivace: samoorganizace nanočástic nad sublimačním rozhraním při řízené vakuové lyofilizaci vede k agregátům s vysokým specifickým povrchem; experimentální popis je obtížný, proto má smysl numerické modelování. (Zdroj: `dvorsky2016`, `krpelik2019`; README startovních materiálů vedoucího shrnuje kontext – samo není citovatelné, cituj primární články.)
2. Návaznost: Fenclová (2014) řešila experimentální přípravu lamelárních struktur, Horáčková (2016) zjednodušenou simulaci agregace v Matlabu. Tato práce na ně navazuje **softwarově**: místo jednorázové simulace vytváří rozšiřitelný nástroj s interaktivní 3D vizualizací.
3. Vymezení: prototyp vizualizačního nástroje, ne úplný fyzikálně-chemický model lyofilizace. Hamakerova interakce je cílový silový model, v základním rozsahu může jít o zjednodušenou podobu nebo demonstrační silové pole.
4. Struktura práce: jedna věta na každou kapitolu.

**Zdroje:** `dvorsky2016`, `krpelik2019`, `fenclova2014`, `horackova2016`; volitelně `bednar2019` (praktické využití materiálů s vysokým SSA).

**Nepatří sem:** podrobný výklad lyofilizace, Hamakerovy teorie nebo technologií (to je kapitola 2), formulace požadavků (kapitola 3).

**Pozn.:** Úvod se píše *naposledy* nebo se na konci přepíše. Ukázka formátu, která v souboru teď je, se smaže.

---

## Kapitola 2 – Analýza současného stavu poznání

Úvodní odstavec kapitoly vysvětlí, proč jsou podkapitoly v tomto pořadí: od fyzikální motivace (2.1–2.2) přes simulační metody (2.3–2.5) k vizualizaci a technologiím (2.6–2.7).

### 2.1 Řízená vakuová lyofilizace nanodisperzí

**Cíl:** Čtenář rozumí procesu, ze kterého pochází fyzikální motivace, a ví, které jevy prototyp (zatím) nemodeluje.

**Klíčové body:**

1. Lyofilizace obecně: zmrazení, primární sušení (sublimace), sekundární sušení (desorpce); role tlaku a teploty. Stručně, jedna až dvě strany. (`oetjen2004`)
2. Řízená vakuová sublimace **nanodisperzí**: ústup sublimačního rozhraní, akumulace nanočástic na rozhraní, vznik lamelárních a fibrilárních struktur s vysokým specifickým povrchem. (`dvorsky2016`, `krpelik2019`, `fenclova2014` kap. 3, patent – doplnit)
3. Co určuje výslednou vazbu mezi částicemi: rychlost při srážce, vazebná energie, mezifázové jevy (mezifázové napětí, ζ-potenciál). (`krpelik2019`)
4. Závěr podkapitoly: které z těchto jevů jsou pro prototyp *mimo rozsah* (proudění par, fázové rozhraní, ζ-potenciál), a proč to nevadí cíli práce.

**Zdroje:** `oetjen2004`, `dvorsky2016`, `krpelik2019`, `fenclova2014`; doplnit patent (CZ 303513 B6 / EP 2751508 B1 – dohledat např. v Espacenet a přidat do `references.bib` jako `@patent`).

**Rozsah:** 2–3 s.

**Nepatří sem:** farmaceutická lyofilizace a návrh sušicích cyklů; podrobná DLVO teorie (stačí zmínka a odkaz).

**Vazby:** 2.2 (síly, které agregaci řídí), kapitola 3 (ne-cíle).

### 2.2 Mezičásticové interakce

**Cíl:** Čtenář ví, odkud se Hamakerova interakce bere, jak vypadá pro dvě koule, jaké má vlastnosti důležité pro výpočet a čím se liší od jednoduchých párových potenciálů.

**Klíčové body:**

1. Van der Waalsovy síly: orientační (Keesom), indukční (Debye), disperzní (London); proč jsou disperzní síly vždy přítomné. (`israelachvili2011`, `horackova2016` kap. 3.2, `fenclova2014`)
2. Párový potenciál jako model: Lennard-Jonesův potenciál jako referenční příklad (přitažlivá a odpudivá část, parametry $\varepsilon$, $\sigma$). (`allen2017`, `frenkel2002`, `nezbeda2003`)
3. Hamakerův přístup: sčítání párových interakcí přes objemy těles, Hamakerova konstanta $A$ a její typické hodnoty. (`hamaker1937`, `israelachvili2011`)
4. **Hamakerův vztah pro dvě koule** (obecný $R_1$, $R_2$ a speciální případ $R_1 = R_2$) s blokem „Kde:“ a jeho limity: blízké koule ($U \sim -1/d$), vzdálené koule ($U \sim -1/d^6$). Vztah ověř a cituj v primárním zdroji `hamaker1937`, ne jen v sekundárním.
5. Síla jako záporný gradient potenciálu: buď analytická derivace, nebo zdůvodnění numerické derivace.
6. **Důsledky pro výpočet** (to je jádro podkapitoly): singularita při kontaktu ($d \to 0$) → nutnost odpudivé složky nebo minimální vzdálenosti; dosah interakce → volba cutoffu (váže se na 2.4); strmost → časový krok (váže se na 2.5).

**Zdroje:** `hamaker1937`, `israelachvili2011`, `allen2017`, `frenkel2002`, `nezbeda2003`, `horackova2016`.

**Rozsah:** 3–4 s.

**Nepatří sem:** retardované van der Waalsovy síly a Lifshitzova teorie (stačí jedna věta, že existují), elektrostatika dvojvrstvy.

**Vazby:** 2.4 (cutoff), 2.5 (časový krok), 3 (požadavek na rozšiřitelný silový model), 4 (výkon pro párové síly).

### 2.3 Molekulární a hrubozrnná částicová simulace

**Cíl:** Čtenář umí zařadit prototyp mezi simulační metody a ví, co je „stav částice“ a „krok simulace“.

**Klíčové body:**

1. Monte Carlo vs. molekulární dynamika – princip, co která metoda dává (rovnovážné vlastnosti vs. časový vývoj); proč zadání vede na dynamiku. (`nezbeda2003`, `frenkel2002`)
2. Atomistická MD vs. hrubozrnný (coarse-grained) popis: nanočástice jako jedna koule s poloměrem, hmotností, polohou a rychlostí. (`allen2017`, `rapaport2004`)
3. Základní smyčka simulace: výpočet sil → integrace → okrajové podmínky → (měření, výstup). Pseudokód nebo diagram je vítaný.
4. Výpočetní složitost párových interakcí $O(N^2)$ a principy, jak ji snížit (cutoff, cell list, Verletův seznam sousedů) – jen princip; implementace je rozšíření. (`allen2017`, `rapaport2004`)
5. Kontext: částicové systémy s kolektivním chováním a mezoskopický popis jako směr pro velká $N$. (`ha2019` – krátce, jen jako výhled)

**Zdroje:** `nezbeda2003`, `allen2017`, `frenkel2002`, `rapaport2004`, `ha2019`.

**Rozsah:** 2–3 s.

**Nepatří sem:** termostaty, statistická mechanika souborů do hloubky, kvantové metody.

**Vazby:** 2.4, 2.5; kapitola 4 (škálování výpočtu k $10^6$ částic).

### 2.4 Periodický prostor a okrajové podmínky

**Cíl:** Čtenář rozumí, jak periodický box napodobuje objemový systém konečným počtem částic, a zná pravidla, která z toho plynou pro výpočet vzdáleností a sil.

**Klíčové body:**

1. Reprezentativní buňka a její periodické obrazy; proč tím odpadají povrchové efekty stěn. (`allen2017`, `frenkel2002`)
2. Vracení částice do buňky (wrapping) po kroku integrace – vzorec pro souřadnici.
3. Úmluva nejbližšího obrazu (minimum image convention) a podmínka na cutoff (cutoff menší než polovina nejkratší hrany boxu).
4. Dlouhodosahové interakce: kdy nejbližší obraz nestačí; souvislost s dosahem Hamakerovy interakce z 2.2.
5. Jiné okrajové podmínky (odrazivá stěna, otevřený prostor) jako alternativa – zdůvodnění, proč je datový model má umět doplnit později.

**Zdroje:** `allen2017`, `frenkel2002`, `rapaport2004`, `nezbeda2003`.

**Rozsah:** 1,5–2 s.

**Nepatří sem:** Ewaldova sumace do detailu (stačí zmínka).

**Vazby:** 3 (funkční požadavek periodické hranice, test), 5+ (datový model domény).

### 2.5 Časová integrace, jednotky a škálování

**Cíl:** Čtenář umí porovnat integrační schémata podle ceny, přesnosti a stability a ví, jak volba jednotek a časového kroku souvisí se stabilitou simulace a plynulostí vizualizace.

**Klíčové body:**

1. Explicitní Euler, semi-implicitní (symplektický) Euler, Verlet / velocity Verlet, leapfrog, Runge–Kutta 4: rovnice, počet vyhodnocení sil na krok, řád přesnosti, zachování energie. Shrnout v tabulce. (`verlet1967`, `allen2017`, `frenkel2002`, `rapaport2004`)
2. Stabilita a velikost kroku: krok musí být malý vůči nejrychlejšímu ději (strmý potenciál z 2.2, srážky). Jak se nestabilita projeví (růst energie, „přeskočení“ částic).
3. Oddělení simulačního času od vykreslování: pevný simulační krok, více podkroků na snímek, nezávislá frekvence přenosu a vykreslování.
4. **Jednotky a škálování:** hmotnosti nanočástic řádově $10^{-20}$ kg a časové škály nanosekund vedou v SI k číslům mimo pohodlný rozsah; redukované (bezrozměrné) jednotky nebo vhodně zvolená soustava (nm, ns, …) a jejich vliv na numerickou přesnost a na datový model. (`rapaport2004`, `allen2017`)
5. Závěr: které schéma je rozumné pro prototyp a proč (bez psaní výsledku dopředu – stačí kritéria, volbu udělá praktická část).

**Zdroje:** `verlet1967`, `allen2017`, `frenkel2002`, `rapaport2004`, `nezbeda2003`.

**Rozsah:** 3–4 s.

**Nepatří sem:** adaptivní krok a implicitní metody do hloubky (zmínka jako rozšíření).

**Vazby:** 3 (nefunkční požadavky na stabilitu a plynulost), 4, 5+ (test časového kroku).

### 2.6 Základy 3D vizualizace

**Cíl:** Čtenář rozumí, co musí vizualizační vrstva řešit, aby šlo plynule zobrazit tisíce až miliony částic s ovládáním kamery a měřítka.

**Klíčové body:**

1. Souřadnicové soustavy a transformace: model → svět → kamera → obrazovka; homogenní souřadnice a matice. (`lengyel2012`)
2. Perspektivní a ortografická projekce, kamera a její ovládání (orbit, zoom, pan). (`lengyel2012`, `eberly2006`)
3. Mapování fyzikálních jednotek (nm, µm) na jednotky scény; zobrazení hranic periodického boxu a periodických obrazů.
4. Vykreslování velkého počtu objektů: instancování, point sprite / impostory místo geometrie koule, úroveň detailu (LOD); proč je počet volání vykreslování (draw calls) úzké hrdlo. (`eberly2006`, dokumentace zvolených knihoven – doplnit)
5. Smyčka vykreslování a snímková frekvence; interpolace mezi simulačními stavy.

**Zdroje:** `lengyel2012`, `eberly2006`; doplnit oficiální dokumentace (WebGL/WebGPU specifikace, Three.js) podle 2.7.

**Rozsah:** 2–3 s.

**Nepatří sem:** osvětlovací modely a shadery do detailu.

**Vazby:** 2.7, 4 (kritérium vykreslování), 5+ (frontend).

### 2.7 Přehled technologií pro výpočet, přenos a vykreslování

**Cíl:** Neutrální přehled **existujících** možností a jejich vlastností. Tady se nic nevybírá – výběr je v kapitole 4.

**Klíčové body:** pro každou osu popsat kandidáty, jejich princip, silné a slabé stránky a doložitelné vlastnosti (dokumentace, specifikace, benchmarky).

1. **Výpočetní jádro:** C++ (vícevláknově na CPU), Python + NumPy/Numba, Rust, JavaScript/TypeScript s WebAssembly v prohlížeči; GPU výpočty (CUDA, SYCL/OpenCL, compute shadery, WebGPU compute).
2. **Vizualizace a GUI:** webové (Three.js, Babylon.js, čisté WebGL/WebGPU), nativní (Qt + VTK, Dear ImGui + OpenGL/Vulkan), vědecké nástroje (PyVista, VPython, ParaView).
3. **Přenos dat backend → frontend:** v rámci procesu (WebUI bridge, sdílená paměť), WebSocket (RFC 6455), žádný přenos (vše v prohlížeči); formáty dat (JSON vs. binární snímky, kvantizace).

**Zdroje:** oficiální dokumentace a specifikace – doplnit do `references.bib` (`@online` s datem citace). Startovní prototyp vedoucího (C++26 + [WebUI](https://github.com/webui-dev/webui) + Three.js) je jedním z popisovaných řešení.

**Rozsah:** 2–3 s.

**Nepatří sem:** hodnocení „co je lepší“ – to patří do kapitoly 4.

---

## Kapitola 3 – Cíle a požadavky

**Cíl:** Jednoznačně stanovit, co má prototyp splnit, aby se dalo na konci ověřit, zda bylo cíle dosaženo. Požadavky jsou **technologicky neutrální** – nesmí v nich být „WebSocket“, „Three.js“ ani „C++“, protože technologie se vybírá až v kapitole 4.

### 3.1 Dílčí cíle

Převést body zadání (EDISON) na kontrolovatelné dílčí cíle. Každý cíl má odkaz na kapitolu, kde se plní, a na test nebo scénář, kterým se ověří.

### 3.2 Funkční požadavky

Očíslované (F1, F2, …), každý jedna věta a kritérium splnění. Minimálně:

- správa částic: přidání a odebrání, počet, rozdělení poloměrů,
- periodický box s nastavitelnými rozměry,
- spuštění, pozastavení a reset; reprodukovatelnost resetu se stejným seedem,
- změna základních parametrů za běhu (časový krok, silový model a jeho parametry),
- 3D scéna s kamerou (orbit, zoom), měřítkem a zobrazením hranic boxu,
- zobrazení stavu výpočtu (simulační čas, FPS simulace a vykreslování, stav spojení).

### 3.3 Nefunkční požadavky

Očíslované (N1, N2, …) a měřitelné:

- výkon: plynulé zobrazení pro řádově $10^3$–$10^4$ částic v základním rozsahu, **architektura bez zjevné bariéry pro škálování k $10^6$** (výpočet, přenos, vykreslování),
- latence odezvy na ovládání,
- rozšiřitelnost: nový silový model, okrajová podmínka nebo integrátor bez zásahu do ostatních vrstev,
- přenositelnost a jednoduchá distribuce,
- testovatelnost backendu bez GUI (automatické testy),
- vhodnost pro vývoj s AI agenty (jasná struktura, rychlá zpětná vazba z překladače a testů).

### 3.4 Vymezení rozsahu (co práce neřeší)

Explicitní seznam ne-cílů se zdůvodněním: přesné řešení kolizí a překryvů, prostorové struktury pro hledání sousedů (jen jako rozšíření), fyzikální validace proti experimentu, modelování sublimačního rozhraní a proudění.

**Zdroje:** zadání práce (EDISON – necituje se jako literatura, ale odkazuje se na něj), kapitola 2.

**Vazby:** kapitola 4 odvozuje kritéria z 3.2–3.3; testovací kapitola praktické části ověřuje F a N požadavky.

---

## Kapitola 4 – Volba technologií

**Cíl:** Doložitelné, opakovatelné rozhodnutí o technologiích pro výpočetní jádro, vizualizaci a GUI a přenos dat. Výsledek se **nepíše dopředu**. Každé bodové hodnocení musí mít zdůvodnění se zdrojem nebo vlastním měřením.

### 4.1 Kritéria a jejich váhy

Každé kritérium: definice, z jakého požadavku (F/N) plyne a váha se zdůvodněním. Kritéria:

| Kritérium | Plyne z | Poznámka |
|---|---|---|
| Interaktivita | F (ovládání za běhu) | odezva na změnu parametrů, kamera |
| Přenositelnost | N | OS, prohlížeč, hardware |
| Jednoduchost distribuce | N | instalace u uživatele, závislosti |
| Napojení na backend | architektura | jak snadno a rychle teče stav k zobrazení |
| Rozšiřitelnost | N | nové síly, okrajové podmínky, vizualizační vrstvy |
| Škálovatelnost – výpočet | N, výhled $10^6$ | CPU/GPU, paralelizace, $O(N^2)$ vs. cell list |
| Škálovatelnost – přenos | N, výhled $10^6$ | $10^6 \times 3 \times$ float32 = 12 MB na snímek; kvantizace, delta, LOD |
| Škálovatelnost – vykreslování | N, výhled $10^6$ | instancování, impostory, draw calls |
| Vhodnost pro AI-asistovaný vývoj | N | dostupnost a kvalita AI asistence, rychlá zpětná vazba (typy, překladač, testy), testovatelnost bez GUI; **nižší váha** než výkon a přenositelnost |
| Přiměřenost rozsahu práce | zadání | učicí křivka, množství kódu, rizika |

### 4.2 Kandidátní řešení

Kombinace ze tří os z 2.7. Do matice patří minimálně:

1. **Návrh vedoucího:** C++ (vícevláknové jádro) + WebUI + Three.js, binární snímky.
2. Python (NumPy/Numba) + webový frontend (WebSocket) + Three.js.
3. Vše v prohlížeči: TypeScript/WebAssembly nebo WebGPU compute + WebGPU/Three.js (bez přenosu).
4. C++ jádro + nativní vykreslování (Dear ImGui + OpenGL/Vulkan, případně Qt + VTK).
5. C++ jádro s GPU výpočtem (CUDA/SYCL/compute shadery) + webový frontend.
6. Vědecký nástroj (PyVista/VTK) jako referenční „hotové“ řešení.

Další kombinace jsou vítané. Návrh vedoucího je jeden z řádků a musí obstát proti ostatním argumenty, ne pocitem.

### 4.3 Rozhodovací matice

Škála 1–5 s ukotvením (1 = kritérium prakticky nesplňuje, 3 = splňuje s výhradami, 5 = splňuje bez výhrad). Kostra (body doplní autor práce):

| Kritérium (váha) | 1 C++/WebUI/Three.js | 2 Python/WS/Three.js | 3 vše v prohlížeči | 4 C++/nativní | 5 C++ GPU/web | 6 PyVista |
|---|---|---|---|---|---|---|
| Interaktivita (?) | | | | | | |
| Přenositelnost (?) | | | | | | |
| Jednoduchost distribuce (?) | | | | | | |
| Napojení na backend (?) | | | | | | |
| Rozšiřitelnost (?) | | | | | | |
| Škálovatelnost – výpočet (?) | | | | | | |
| Škálovatelnost – přenos (?) | | | | | | |
| Škálovatelnost – vykreslování (?) | | | | | | |
| AI-asistovaný vývoj (?) | | | | | | |
| Přiměřenost rozsahu (?) | | | | | | |
| **Vážený součet** | | | | | | |

Pod maticí je ke každé buňce (nebo ke každému řádku) zdůvodnění s citací nebo s odkazem na vlastní měření. Pokud se rozhoduje na základě měření (například jednoduchý benchmark přenosu 12 MB snímku), popiš metodiku a prostředí, aby šlo měření zopakovat. Zdrojový kód benchmarku patří do `app/`.

Matici ukaž i jako citlivostní analýzu: změní se pořadí, když se upraví váhy výkonu a přiměřenosti rozsahu?

### 4.4 Zvolené řešení a přijatá omezení

Volba, shrnutí důvodů a **vědomě přijaté nevýhody** včetně toho, jak je zmírnit (například binární snímky, kvantizace, oddělená frekvence přenosu). Na tuto podkapitolu navazuje návrh architektury v praktické části.

**Zdroje:** dokumentace a specifikace z 2.7, vlastní měření.

**Rozsah:** 4–6 s.

---

## Praktická část (kapitola 5 a dál) – odloženo

Domluví se zvlášť. Už teď je jasné, že bude obsahovat:

- návrh architektury (oddělení výpočetního jádra, přenosu a frontendu; rozhraní pro silové modely, integrátory a okrajové podmínky; datový model a serializace) – zdroje `gamma1994`, `martin2017`,
- implementaci prototypu v `app/`,
- testovací a demonstrační scénáře (dvě částice, periodická hranice, vliv časového kroku, ovládání, výkon),
- **metodiku práce s AI agenty**: jak se agent řídil, jaké prompty a pravidla se použily, jak se výstupy ověřovaly. Podklady sbírej průběžně do `notes/ai-log.md`.
