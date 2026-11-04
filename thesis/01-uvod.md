# Úvod {#sec:uvod}

<!--
Zadání kapitoly: docs/osnova.md, sekce „Kapitola 1 – Úvod“.
Doporučený rozsah: 1,5–2 strany.
-->

TODO Úvod podle zadání v `docs/osnova.md`.

<!--
==========================================================================
UKÁZKA FORMÁTU – po napsání úvodu celý tento blok smažte.
Ukazuje citaci s lokátorem, číslovanou rovnici s blokem „Kde:“, obrázek
s popiskem a odkazy na ně. Citovaný citát je v literature/horackova2016.md.
==========================================================================
-->

Na práci přímo navazuje zjednodušená simulace agregace nanočástic realizovaná v programu Matlab [@horackova2016, s. 4], ve které byla interakce mezi dvěma kulovými částicemi popsána Hamakerovým vztahem [@horackova2016, s. 18]. Pro dvě částice stejného poloměru má tvar uvedený v [@eq:hamaker-stejne-koule].

$$
U(d) = -\frac{A}{6}\left[\frac{2R^2}{(4R+d)\,d} + \frac{2R^2}{(2R+d)^2} + \ln\frac{(4R+d)\,d}{(2R+d)^2}\right]
$$ {#eq:hamaker-stejne-koule}

::: kde
- $U$ – potenciální energie interakce [J]
- $A$ – Hamakerova konstanta [J]
- $R$ – poloměr obou částic [m]
- $d$ – vzdálenost povrchů částic [m]
:::

Vizuální podobu startovního prototypu ukazuje [@fig:starter].

![Startovní prototyp (C++/WebUI/Three.js), zdroj: vedoucí práce](figures/starter-prototyp.png){#fig:starter width=80%}

<!-- KONEC UKÁZKY -->
