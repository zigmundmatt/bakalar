VYSOKÁ ŠKOLA BÁŇSKÁ – TECHNICKÁ UNIVERZITA OSTRAVA
FAKULTA MATERIÁLOVĚ-TECHNOLOGICKÁ

===================================================================
PODKLAD A STRUKTURÁLNÍ OSNOVA BAKALÁŘSKÉ PRÁCE
Metodické odůvodnění kapitol a tematických celků
===================================================================

Téma práce: Simulace vakuového vymrazování (sublimace) a částicová/molekulární dynamika s využitím periodického prostoru
Typ práce: Bakalářská práce
Cílové prostředí: WebGL, JavaScript / TypeScript, Three.js

-------------------------------------------------------------------

ÚVOD

Odůvodnění zařazení:
Úvod zasazuje problematiku vakuového vymrazování (lyofilizace) do kontextu moderního materiálového inženýrství, farmacie a nanotechnologií. Formuluje základní výzkumnou a technickou motivaci – opuštění složitých parciálních diferenciálních rovnic mechaniky kontinua a jejich nahrazení diskrétní částicovou dynamikou. Stanovuje hlavní cíl práce (vývoj interaktivní 2D a následně 3D webové simulace ve WebGL) a definuje soubor dílčích cílů nutných k jeho dosažení.

-------------------------------------------------------------------

1. FYZIKÁLNÍ PRINCIPY VAKUOVÉHO VYMRAZOVÁNÍ (LYOFILIZACE)

Odůvodnění kapitoly:
Vytváří nezbytný teoretický fundament. Bez exaktního popisu fázového rozhraní, chování vody za sníženého tlaku a režimů proudění zředěných plynů nelze stanovit správné fyzikální mantinely pro částicový model ani věrohodně interpretovat výsledky simulace.

1.1 Fázové přechody a stavový diagram vody
Odůvodnění:
Vymezuje termodynamické podmínky existence fází. Umožňuje definovat stavový prostor, ve kterém dochází k přímé sublimaci bez přechodu do kapalného stavu.

* 1.1.1 Trojný bod vody a oblast stability jednotlivých fází
  Odůvodnění: Definuje striktní mezní parametry (teplota 0,01 °C, tlak 611,65 Pa). Tyto hodnoty slouží jako přímé limitní podmínky pro nastavení vstupních parametrů v simulačním programu.

* 1.1.2 Termodynamická rovnováha na rozhraní led–pára
  Odůvodnění: Popisuje mikroskopickou dynamickou rovnováhu mezi desorpcí molekul z ledu a jejich zpětnou kondenzací (resublimací), což je klíčové pravidlo pro chování částic na fázovém rozhraní.

* 1.1.3 Sublimační entalpie a Clausiova–Clapeyronova rovnice
  Odůvodnění: Poskytuje analytický vztah mezi teplotou ledu a rovnovážným tlakem sytých par. Slouží k matematické verifikaci, zda rychlost sublimace v simulaci odpovídá reálným termodynamickým zákonům.

1.2 Kinetika a fáze lyofilizačního procesu
Odůvodnění:
Popisuje časový a procesní průběh sušení v průmyslové praxi a přesně specifikuje, kterou část procesu software modeluje.

* 1.2.1 Fáze primárního sušení (odvod volného ledu sublimací)
  Odůvodnění: Představuje samotné těžiště simulace. Během této fáze ustupuje ledové čelo a vzniká proud vodní páry, což je proces vizualizovaný v aplikaci.

* 1.2.2 Fáze sekundárního sušení (desorpce vázané vlhkosti)
  Odůvodnění: Vymezuje rozsah práce. Odůvodňuje, proč se model soustředí výhradně na krystalický led a proč je desorpce zbytkové vázané vody z důvodu výpočetní náročnosti z modelu vynechána.

* 1.2.3 Vliv podtlaku, geometrie lože a tvorby pórů
  Odůvodnění: Popisuje vznik porézního skeletu vysušeného materiálu, kterým musí sublimované částice procházet, což generuje odpor proti toku hmoty.

1.3 Transportní jevy ve vakuu a porézním prostředí
Odůvodnění:
Poskytuje vědecký důkaz pro opuštění rovnic kontinua a přechod k částicové kinetické teorii.

* 1.3.1 Mechanismy přenosu tepla k sublimačnímu rozhraní
  Odůvodnění: Jelikož je sublimace endotermní děj, vysvětluje přívod tepla ze sušicích polic (kondukce) a stěn komory (radiace) a jeho přímou vazbu na kinetickou energii částic.

* 1.3.2 Přenos hmoty ve zředěném plynu
  Odůvodnění: Teoreticky formuluje gradient tlaku mezi sublimačním čelem a vakuovým kondenzátorem, který určuje výsledný drift částic směrem k odsávání.

* 1.3.3 Knudsenovo číslo a režimy proudění
  Odůvodnění: Zásadní teoretický pilíř. Výpočtem Knudsenova čísla (Kn > 10) prokazuje, že se plyn nachází v molekulárním režimu, kde částice narážejí primárně do stěn/pórů a nikoliv do sebe navzájem, což plně ospravedlňuje částicový model.

-------------------------------------------------------------------

2. PRINCIPY ČÁSTICOVÝCH SIMULACÍ A MOLEKULÁRNÍ DYNAMIKY

Odůvodnění kapitoly:
Seznamuje s matematickým a fyzikálním aparátem diskrétních částic. Objasňuje, jak lze z mikroskopického pohybu a srážek odvodit makroskopické stavové veličiny jako teplota a tlak.

2.1 Deterministické vs. stochastické přístupy k modelování látek
Odůvodnění:
Porovnává výpočetní metody a zdůvodňuje volbu inženýrského zjednodušení pro webové prostředí.

* 2.1.1 Klasická molekulární dynamika vs. kinetické Monte Carlo
  Odůvodnění: Demonstruje, proč je atomární integrace femtosekundových kroků v reálném čase v prohlížeči nerealizovatelná a proč je nutné zvolit stochasticko-deterministický kompromis.

* 2.1.2 Fenomenologické diskrétní částicové modely
  Odůvodnění: Definuje koncept simulační pseudočástice reprezentující diskrétní balík hmoty, což umožňuje plynulou simulaci v reálném čase při zachování fyzikálních zákonů zachování hybnosti.

2.2 Kinetická teorie plynů v částicovém pojetí
Odůvodnění:
Dodává pohybovým rovnicím částic statisticky korektní chování odpovídající chování reálného plynu.

* 2.2.1 Maxwellovo–Boltzmannovo rozdělení rychlostí
  Odůvodnění: Zajišťuje, aby nově sublimované částice měly rychlosti odpovídající termodynamické teplotě ledu podle pravděpodobnostního rozdělení.

* 2.2.2 Mikroskopická definice teploty a tlaku
  Odůvodnění: Definuje algoritmus přepočtu stavu částic na makroskopické ukazatele – kinetickou teplotu ze střední kvadratické rychlosti a tlak z impulsu síly předaného hranicím.

* 2.2.3 Střední volná dráha a pravděpodobnost mezičásticové srážky
  Odůvodnění: Určuje geometrická a kolizní kritéria pro interakce mezi částicemi uvnitř simulačního objemu.

2.3 Částicové interakce a modelování fázového rozhraní
Odůvodnění:
Popisuje vazebné síly držící pevnou fázi pohromadě a formuluje podmínku uvolnění částice z ledové matrice.

* 2.3.1 Modely částic (Hard-Sphere model vs. Lennard-Jonesův potenciál)
  Odůvodnění: Zdůvodňuje použití modelu pevných elastických koulí (Hard-Sphere) z důvodu radikální optimalizace výpočtu kolizí oproti výpočtu spojitých potenciálů.

* 2.3.2 Energetická bariéra úniku částice z krystalové mřížky ledu
  Odůvodnění: Matematizuje fázový přechod – částice unikne z ledu pouze při překročení vazebné energie sublimace dané fluktuací energie.

-------------------------------------------------------------------

3. MATEMATICKÉ MODELOVÁNÍ PERIODICKÉHO PROSTORU

Odůvodnění kapitoly:
Řeší klíčový metodický problém práce: jak s omezeným počtem částic (tisíce namísto sextilionů) věrohodně reprezentovat neomezený objem média bez deformací způsobených odrazy od stěn.

3.1 Problém okrajových jevů v mikroskopických simulacích
Odůvodnění:
Analyzuje chyby vznikající při uzavření malého počtu částic do pevné nádoby.

* 3.1.1 Vliv fyzikálních stěn na statistiku částic (Wall-effects)
  Odůvodnění: Prokazuje, že v malém objemu většina částic neustále koliduje se stěnami, což způsobuje nerealistickou anizotropii tlaku a deformaci střední volné dráhy.

* 3.1.2 Reprezentativní objemový prvek (RVE)
  Odůvodnění: Definuje simulační buňku jako lokální vzorek materiálu, který vykazuje shodné vlastnosti jako makroskopický celek.

3.2 Periodické okrajové podmínky (Periodic Boundary Conditions – PBC)
Odůvodnění:
Představuje rigorózní matematický aparát bezešvého prostoru.

* 3.2.1 Topologie toru a bezešvé propojení protilehlých hranic
  Odůvodnění: Formuluje rovnice toroidálního mapování (wrap-around), kde částice opouštějící doménu okamžitě vstupuje na protilehlé straně se zachováním vektoru hybnosti.

* 3.2.2 Konvence minimálního obrazu (Minimum Image Convention)
  Odůvodnění: Matematický algoritmus určující nejkratší vzdálenost mezi částicemi napříč periodickými hranicemi, což zabraňuje falešným interakcím přes celý box.

3.3 Zrcadlení a práce se sousedními buňkami (Ghost / Image Cells)
Odůvodnění:
Popisuje geometrické řešení pro zobrazení a výpočet interakcí v hraničních zónách.

* 3.3.1 2D prostor: Centrální buňka a 8 sousedních obrazů
  Odůvodnění: Definuje soustavu 8 prostorových posunů pro 2D model, umožňující vizuální plynulost a správné vyhodnocení sousedství před přechodem do 3D.

* 3.3.2 3D prostor: Rozšíření na 26 sousedních domén
  Odůvodnění: Formuluje plné prostorové rozšíření (3³ - 1 = 26 sousedních buněk), což je nezbytný matematický podklad pro finální 3D simulaci.

3.4 Výpočetní složitost a prostorové indexování (Spatial Grid / Cell Lists)
Odůvodnění:
Řeší problém kvadratické složitosti O(N²) při detekci kolizí. Rozdělení domény na podbuňky redukuje složitost na O(N), což je zásadní podmínka pro udržení 60 FPS v prohlížeči.

-------------------------------------------------------------------

4. NÁVRH SIMULAČNÍHO MODELU A ARCHITEKTURY APLIKACE

Odůvodnění kapitoly:
Převádí teoretické fyzikální a matematické rovnice do konkrétního softwarového návrhu, datových struktur a algoritmických diagramů před samotnou implementací.

* 4.1 Diskrétní pravidla fázového přechodu pevná fáze–plyn
  Odůvodnění: Definuje stavový automat částice (pevná vázaná fáze, uvolněná pára, odstraněná částice v kondenzátoru).

* 4.2 Algoritmus periodického zrcadlení a detekce kolizí
  Odůvodnění: Popisuje strukturovaný algoritmus spojení prostorové mřížky s periodickými podmínkami.

* 4.3 Softwarová architektura aplikace ve Three.js
  Odůvodnění: Zdůvodňuje návrh modulárního členění systému (fyzikální integrační jádro, renderovací subsystém, uživatelské rozhraní) podle principů softwarového inženýrství.

-------------------------------------------------------------------

5. IMPLEMENTACE A UŽIVATELSKÉ ROZHRANÍ

Odůvodnění kapitoly:
Poskytuje technickou dokumentaci vývoje v prostředí WebGL, knihovny Three.js a moderního JavaScriptu/TypeScriptu.

* 5.1 Vývoj 2D prototypu
  Odůvodnění: Demonstruje systematický inženýrský postup: ověření správnosti fyziky a 8 periodických obrazů na jednoduchém 2D modelu před přechodem do 3D.

* 5.2 Rozšíření do 3D prostoru
  Odůvodnění: Popisuje realizaci plnohodnotné 3D scény s kamerou, osvětlením a 26 replikovanými doménami.

* 5.3 Optimalizace vykreslování (InstancedMesh a paměťový management)
  Odůvodnění: Popisuje technické řešení hardwarového instancingu na GPU, které umožňuje vykreslovat desítky tisíc částic bez přetížení procesoru.

* 5.4 Interaktivní řízení parametrů simulace
  Odůvodnění: Prezentuje ovládací panel (změna teploty, výkonu odsávání, vizualizace hranic buněk) a zajišťuje didaktickou použitelnost programu.

-------------------------------------------------------------------

6. VÝSLEDKY, VERIFIKACE A DISKUZE

Odůvodnění kapitoly:
Přináší kritické vyhodnocení. Dokazuje fyzikální platnost vytvořeného simulačního nástroje a kvantifikuje jeho výpočetní limity.

* 6.1 Kvalitativní shoda částicového modelu s fyzikálními trendy
  Odůvodnění: Verifikuje, zda rychlost sublimace a chování par odpovídá očekávaným termodynamickým závislostem při změně teploty a tlaku.

* 6.2 Analýza výkonu a škálovatelnosti
  Odůvodnění: Obsahuje naměřené grafy závislosti FPS na počtu částic a velikosti mřížky na různých hardwarových konfiguracích.

* 6.3 Limity modelu a možnosti dalšího rozvoje
  Odůvodnění: Otevřeně reflektuje zjednodušení modelu a navrhuje další směřování výzkumu (např. implementaci výpočtů v compute shaderech WebGPU).

-------------------------------------------------------------------

ZÁVĚR

Odůvodnění zařazení:
Shrnuje naplnění cílů práce, rekapituluje dosažené vědecko-technické výsledky a definuje přínos vytvořené interaktivní simulace pro výuku a výzkum na VŠB-TUO.

-------------------------------------------------------------------

SEZNAM POUŽITÉ LITERATURY A INFORMAČNÍCH ZDROJŮ

Odůvodnění zařazení:
Nezbytná formální součást práce dle normy ČSN ISO 690, která prokazuje práci s autoritativními vědeckými monografiemi a články z oblasti lyofilizace (Rey, Pikal), molekulární simulace (Allen & Tildesley, Frenkel & Smit) a grafických standardů WebGL.

