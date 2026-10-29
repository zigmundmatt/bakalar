# Návrh osnovy bakalářské práce

**Název:** Vizualizace částicové dynamiky v Hamakerově modelu interakce

## 1. Úvod

Úvod stručně představí motivaci lyofilizací a vymezí práci jako návrh a implementaci vizualizačního prototypu, nikoli úplného fyzikálně-chemického modelu.

**Relevantní literatura:** Oetjen a Haseley [1]; Hamaker [2]; Bass, Clements a Kazman [12].

## 2. Cíle, rozsah a požadavky

Kapitola stručně stanoví cíl a hranice práce: funkční částicový prototyp s periodickým boxem a webovou vizualizací; Hamakerova interakce je rozšířením.
- **Funkce:** správa částic, spuštění, pozastavení, reset a změna parametrů.
- **Ověření:** test dvou částic a periodické hranice, měření WebSocket latence a FPS.
- **Rozšiřitelnost:** oddělení simulace, okrajových podmínek a silového modelu.

**Relevantní literatura:** Bass, Clements a Kazman [12]; RFC 6455 [7].

## 3. Teoretická východiska

Kapitola stručně vymezí fyzikální motivaci, částicové simulace, periodické podmínky a časovou integraci.

### 3.1 Vakuové vymrazování (lyofilizace) a sublimace

Popsat zmrazení, primární sušení sublimací a sekundární sušení desorpcí a vysvětlit roli tlaku a teploty. Lyofilizace je fyzikální motivací, nikoli úplným modelem prototypu.

**Relevantní literatura:** Oetjen a Haseley [1]; Tang a Pikal [13].

### 3.2 Molekulární a částicové simulace

Odlišit atomistickou molekulární dynamiku od hrubozrnné částicové simulace a popsat stav částice a základní výpočetní krok. Prototyp použije částicový popis; Hamakerova interakce zůstane volitelná.

**Relevantní literatura:** Hamaker [2]; Israelachvili [3]; Allen a Tildesley [4]; Frenkel a Smit [5].

### 3.3 Periodický prostor a periodické okrajové podmínky

Stručně popsat reprezentativní buňku, periodické kopie a zacházení s částicemi u hranic. Vysvětlit, kdy stačí nejbližší obraz a proč u dlouhodosahových interakcí záleží na cutoffu a dalších obrazech. Cílem je zdůvodnit, jak tato aproximace umožňuje simulovat objemový systém s omezeným počtem částic.

**Relevantní literatura:** Allen a Tildesley [4]; Frenkel a Smit [5]; Hamaker [2]; Israelachvili [3].

### 3.4 Časová integrace částicové dynamiky

Stručně porovnat explicitní a semi-implicitní Eulerovu metodu, Verlet/velocity-Verlet a Rungeho–Kuttu z hlediska ceny, přesnosti a stability.

Pro demonstrační prototyp lze použít semi-implicitní Euler; u konzervativních sil porovnat velocity-Verlet. Časový krok ověřit zejména pro strmé interakce a oddělit jej od frekvence vykreslování.

**Relevantní literatura:** Allen a Tildesley [4]; Frenkel a Smit [5]; Verlet [6]; Beeman [14].

## 4. Porovnání technologií a zdůvodnění volby

Porovnat alternativy a zdůvodnit volbu Python/FastAPI, WebSocketů a TypeScriptu s Three.js pro přenosný webový prototyp.

### 4.1 Backend a uživatelské rozhraní

Porovnat Python/FastAPI s Node.js a nativním jádrem; volbu zdůvodnit jednoduchostí vývoje a podporou WebSocketů.

**Relevantní literatura:** dokumentace FastAPI [10]; Bass, Clements a Kazman [12].

### 4.2 Technologie 3D vykreslování

Porovnat WebGL, Three.js a Babylon.js podle náročnosti, přenositelnosti a podpory kamery a částicové scény.

**Relevantní literatura:** MDN Web Docs [8]; dokumentace Three.js [9]; dokumentace Babylon.js [11].

### 4.3 WebSocket komunikace

Zdůvodnit WebSockety pro průběžné aktualizace a popsat hlavní zprávy mezi frontendem a backendem.

**Relevantní literatura:** RFC 6455 [7]; dokumentace FastAPI [10].

## 5. Návrh aplikace

Navrhnout oddělené jádro simulace, komunikační vrstvu a frontend tak, aby šly měnit silové modely a okrajové podmínky.

- **Jádro simulace:** stav částic, časový krok a výpočet nového stavu.
- **Rozšiřitelné modely:** samostatná rozhraní pro silové pole, integrátor a okrajové podmínky; základní implementace může být záměrně jednoduchá.
- **Komunikační vrstva:** WebSocket zprávy pro ovládání simulace a přenos aktualizací.
- **Frontend:** ovládací prvky, 3D scéna, kamera, měřítko a vizuální stav spojení.
- **Datový model a serializace:** jednoznačné jednotky, struktura zpráv a způsob přenosu poloh a dalších údajů o částicích.

**Relevantní literatura:** Bass, Clements a Kazman [12]; RFC 6455 [7]; dokumentace FastAPI [10] a Three.js [9].

## 6. Implementace prototypu

Popsat implementaci backendu, WebSocket komunikace a frontendového ovládání a 3D scény.

**Relevantní literatura:** dokumentace Python/FastAPI [10]; dokumentace Three.js [9]; MDN WebGL [8].

## 7. Testování a demonstrační scénáře

Ověřit funkce i výkon na reprodukovatelných scénářích a uvést konfiguraci, prohlížeč a hardware.

### 7.1 Funkční a numerické testy

- **Test dvou částic:** ověřit předvídatelný vývoj poloh například při volném pohybu; pokud je implementována interakce, doplnit kontrolní scénář pro její očekávaný účinek.
- **Test periodické hranice:** částice překročí stěnu boxu a znovu se objeví na protější straně; ověřit výslednou souřadnici a spojitost relevantní vzdálenosti.
- **Test časového kroku:** porovnat vývoj pro několik hodnot kroku a popsat vliv na stabilitu, odchylku a plynulost zobrazení.
- **Test ovládání:** ověřit spuštění, pozastavení, reset a změnu parametrů.

**Relevantní literatura:** Allen a Tildesley [4]; Frenkel a Smit [5]; Verlet [6].

### 7.2 Test komunikace a výkonu

- **Latence WebSocketu:** měřit dobu odezvy nebo round-trip latenci a reportovat alespoň medián a vyšší percentil, například 95. percentil.
- **Propustnost aktualizací:** zaznamenat počet přenesených aktualizací za sekundu a případně velikost zpráv.
- **Plynulost vykreslování:** porovnat snímkovou frekvenci při několika počtech částic za stejných podmínek.
- **End-to-end scénář:** spustit simulaci, upravit parametr a ověřit, že se změna projeví v zobrazení.

Výsledky budou prezentovány jako měření konkrétního prototypu a prostředí, nikoli jako obecné výkonnostní záruky.

**Relevantní literatura:** RFC 6455 [7]; dokumentace FastAPI [10]; MDN WebGL [8].

## 8. Výsledky a diskuse

Vyhodnotit testy, splnění cílů a limity výkonu; odlišit funkční ověření od fyzikální validace.

**Relevantní literatura:** Allen a Tildesley [4]; Bass, Clements a Kazman [12].

## 9. Závěr

Shrnout splnění cílů a navrhnout další rozvoj: přesnější síly, kolize, výkonnější algoritmy a experimentální validaci.

**Relevantní literatura:** Hamaker [2]; Israelachvili [3]; Frenkel a Smit [5].

## Seznam použité literatury a zdrojů

1. OETJEN, G. W.; HASELEY, P. *Freeze-Drying*. 2. vyd. Weinheim: Wiley-VCH, 2004.
2. HAMAKER, H. C. The London—van der Waals attraction between spherical particles. *Physica*. 1937, 4(10), 1058–1072.
3. ISRAELACHVILI, J. N. *Intermolecular and Surface Forces*. 3. vyd. Academic Press, 2011.
4. ALLEN, M. P.; TILDESLEY, D. J. *Computer Simulation of Liquids*. 2. vyd. Oxford University Press, 2017.
5. FRENKEL, D.; SMIT, B. *Understanding Molecular Simulation: From Algorithms to Applications*. 2. vyd. Academic Press, 2002.
6. VERLET, L. Computer “Experiments” on Classical Fluids. I. Thermodynamical Properties of Lennard-Jones Molecules. *Physical Review*. 1967, 159(1), 98–103.
7. FETTE, I.; MELNIKOV, A. *The WebSocket Protocol*. RFC 6455. IETF, 2011. Dostupné z: https://www.rfc-editor.org/rfc/rfc6455
8. MDN WEB DOCS. *WebGL API*. Dostupné z: https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API
9. THREE.JS. *Three.js Documentation*. Dostupné z: https://threejs.org/docs/
10. FASTAPI. *WebSockets*. Dostupné z: https://fastapi.tiangolo.com/advanced/websockets/
11. BABYLON.JS. *Documentation*. Dostupné z: https://doc.babylonjs.com/
12. BASS, L.; CLEMENTS, P.; KAZMAN, R. *Software Architecture in Practice*. 4. vyd. Addison-Wesley, 2021.
13. TANG, X.; PIKAL, M. J. Design of freeze-drying processes for pharmaceuticals: practical advice. *Pharmaceutical Research*. 2004, 21, 191–200.
14. BEEMAN, D. Some multistep methods for use in molecular dynamics calculations. *Journal of Computational Physics*. 1976, 20(2), 130–139.
