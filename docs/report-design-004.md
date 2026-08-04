# Report Design

## Business Objective
A nagyértékű károk elemzése régió és termék szerint, különös tekintettel az 500 000 Ft feletti kárösszegekre, hogy a döntéshozók gyorsan lássák a legnagyobb kockázatokat és fókuszterületeket.

## Pages

### Executive Summary
- Cél: Áttekintést adni a nagyértékű károk összképéről és kiemelni a legfontosabb régiókat és termékeket.
- KPI kártyák:
  - Összes nagyértékű kárösszeg
  - Nagyértékű károk darabszáma
  - Top 3 régió nagyértékű kárösszeg alapján
  - Top 3 termék nagyértékű kárösszeg alapján
- Vizualizációk:
  - KPI kártyák összegzése
  - Top régiók/termékek összegző diagramja
  - Összes nagyértékű kár megoszlása régió és termék szerint
- Üzleti indoklás:
  - Gyors vezetői áttekintés, hogy hol összpontosulnak a legnagyobb értékű károk.
  - Támogatja a stratégiai döntéseket a fókuszterületek azonosításában.

### Region Analysis
- Cél: Mélyebben feltérképezni a nagyértékű károk eloszlását régiók szerint.
- KPI kártyák:
  - Legnagyobb kárösszegű régió
  - Legmagasabb darabszámú régió
  - Átlagos nagyértékű kár összege régiónként
- Vizualizációk:
  - Rendezett oszlopdiagram régió szerint
  - Mátrix régió vs. termék nagyértékű kárösszeggel
  - Régió szűrő/szeletelő
- Üzleti indoklás:
  - Lehetővé teszi a régióspecifikus kockázati minták felismerését.
  - Segít azonosítani a legerősebb és leggyengébb teljesítményű területeket a károk kezelése szempontjából.

### Product Analysis
- Cél: Elemzeni a nagyértékű károkat termékdimenzióban.
- KPI kártyák:
  - Legnagyobb kárösszegű termék
  - Legnagyobb kárdarabszámú termék
  - Termékspecifikus átlagos nagyértékű kár
- Vizualizációk:
  - Csoportosított oszlopdiagram termékek szerint
  - Mátrix termék vs. régió értékekkel
  - Termék szűrő/szeletelő
- Üzleti indoklás:
  - Rávilágít a termékeloszlásból adódó kockázatokra.
  - Segít a termékportfólió optimalizálásában és a kárkezelési prioritások meghatározásában.

### Governance & Data Quality
- Cél: Feltárni az esetleges adathiányokat, biztonsági és adatminőségi kockázatokat a nagyértékű kár riportban.
- KPI kártyák:
  - Hiányzó régióadatok aránya
  - Hiányzó termékadatok aránya
  - Kárösszeg nélküli sorok száma
- Vizualizációk:
  - Adatminőségi mutatók táblázata
  - Háromszögdiagram/indikátorok a hiányzó adatokra
  - Adatminőség szűrők (hiányzó értékek)
- Üzleti indoklás:
  - Biztosítja, hogy a döntés-előkészítő riport megbízható alapokon álljon.
  - Felhívja a figyelmet a hiányos vagy biztonsági szempontból problémás adatokra.

## Filters
- Időszak (ClaimDate, ha elérhető)
- Régió
- Termék
- Nagyértékű kár küszöb (pl. > 500 000 Ft)

## KPI Cards
- Összes nagyértékű kárösszeg
- Nagyértékű károk darabszáma
- Top 3 régió nagyértékű kárösszeg szerint
- Top 3 termék nagyértékű kárösszeg szerint
- Hiányzó adatok aránya régió/termék/kárösszeg mezőkben

## Navigation
- Oldalsáv vagy felső navigáció a négy oldal között
- Gyors elérés Executive Summary → Region Analysis → Product Analysis → Governance & Data Quality

## Security Considerations
- Ellenőrizni kell, hogy a riporthoz hozzáférők jogosultak-e nagyértékű káradatok megtekintésére
- Meg kell határozni, van-e szükség sor szintű biztonságra
- Figyelembe venni az adatvédelmi korlátozásokat a kárösszeg megjelenítésekor

## Open Questions
- Mely felhasználói szerepek használják a riportot?
- Vannak-e vállalati vizuális irányelvek vagy formátumkövetelmények?
- Szükséges-e sor szintű biztonsági szűrés?
- Mely időtartományok legyenek alapértelmezettként elérhetők?
