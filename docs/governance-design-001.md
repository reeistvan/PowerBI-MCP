# Governance & Data Quality Design

## Business Objective

A Governance & Data Quality oldal célja, hogy lehetővé tegye a nagyértékű károk adatminőségének gyors értékelését, a hiányzó adatok azonosítását és a riport megbízhatóságának ellenőrzését. A fő üzleti kérdés az, hogy az adatok elegendően teljesek és megbízhatóak-e ahhoz, hogy a döntéshozók a régió- és termékalapú elemzéseket biztonsággal használhassák.

## KPI Cards

Az oldal kulcsfontosságú KPI-kártyái a következők legyenek:

- Total Records
- Missing Region Records
- Missing Product Records
- Missing ClaimAmount Records
- Data Quality Score

A Data Quality Score egy egyszerűen értelmezhető, auditálható mutató legyen, amely a kritikus mezők hiányzási arányát veszi figyelembe.

## Data Quality Score Calculation

Cél:

A Data Quality Score KPI egyértelmű, auditálható és reprodukálható definíciójának dokumentálása.

### Option A - Simple Score

Data Quality Score =

100%
- Missing ClaimAmount %
- Missing Region %
- Missing Product %
- Missing ClaimDate %

Megjegyzés:

Ez az egyszerű megközelítés könnyen érthető a döntéshozók számára, de minden kritikus mezőt azonos súllyal kezel.

### Option B - Weighted Score (Recommended)

Súlyok:

- ClaimAmount = 40%
- ClaimDate = 20%
- Region = 20%
- Product = 20%

Értelmezés:

A ClaimAmount hiánya kiemelt üzleti kockázatot jelent, ezért nagyobb súlyt kap.

A Region, Product és ClaimDate mezők szintén kritikusak, de kisebb üzleti hatással bírnak.

### Governance Rule

A Data Quality Score számítási logikáját dokumentálni kell.

A módosítások esetén:

- verziókövetés szükséges
- üzleti jóváhagyás szükséges
- a riport dokumentációját frissíteni kell

## Data Quality Score Calculation Details

### Calculation Logic

A Data Quality Score a következőképpen számítandó:

- indulás 100%-ból
- levonandó a hiányzó ClaimAmount rekordok százaléka
- levonandó a hiányzó Region rekordok százaléka
- levonandó a hiányzó Product rekordok százaléka
- levonandó a hiányzó ClaimDate rekordok százaléka

### Recommended Interpretation

- 100% = nincs kritikus adatminőségi probléma
- 90%–99% = kisebb adatminőségi aggodalom
- 80%–89% = közepes minőségi kockázat
- 80% alatt = jelentős adatminőségi kockázat

### Governance Note

Ezt a KPI-t a következőkkel együtt kell dokumentálni:
- számítási módszer
- forrásmezők listája
- verziótörténet
- üzleti jóváhagyási nyilvántartás

## Visuals

### Missing Data Overview

Egy összegző vizualizáció, amely megmutatja, hogy az egyes kritikus oszlopokból hány rekord hiányzik. Célja a leggyakoribb adatminőségi problémák azonosítása.

### Data Quality by Column

Oszlopdiagram vagy bárdiagram, amely a mezők szerinti hiányzási arányt jeleníti meg. Ez segít megérteni, mely mezők okoznak a legtöbb problémát.

### Record Completeness Distribution

Vizualizáció a rekordok teljesítettségi szintjéről. Célja, hogy látható legyen, hány rekord teljes, és hány tartalmaz hiányzó kritikus mezőt.

### Data Quality Trend

Vonaldiagram vagy időbeli trend vizualizáció, amely megmutatja, hogyan változik az adatminőség az időben. Ez segít a minőségromlás vagy javulás nyomon követésében.

## Filters

Az oldal használatát a következő szűrők támogatják:

- Time Period
- Region
- Product
- Data Quality Status
- Missing Data Type

Ajánlott működés:

- az időszak szűrő legyen alapértelmezett és könnyen elérhető
- a régió és termék szűrő segít a minőségi problémák szegmentálásában
- a hiányzó adat típusa szerinti szűrő legyen különösen hasznos a fókuszterületek azonosításához

## Data Quality Rules

Az oldal támogatnia kell az alábbi adatminőségi szabályokat:

- ClaimAmount mező kötelezően kitöltött kell legyen
- Region mező kötelezően kitöltött kell legyen
- Product mező kötelezően kitöltött kell legyen
- ClaimDate mező kötelezően kitöltött kell legyen
- a hiányzó kritikus mezők esetén a rekord minősége romlik
- a nagyértékű kár szabálya továbbra is következetesen alkalmazandó:
  - ClaimAmount greater than 500000 = high value claim

További ajánlott szabályok:

- duplikált rekordok azonosítása
- hiányzó vagy érvénytelen dátumok ellenőrzése
- üres vagy nem értelmezhető régió/termék értékek kezelése

## Governance Considerations

### Auditability

A riportnak tartalmaznia kell a minőségi ellenőrzések nyomon követhetőségét. A döntéshozók számára fontos, hogy lássák, honnan származik az adat, és hogyan lett ellenőrizve.

### Data Ownership

A dokumentációban egyértelműen meghatározandó, hogy ki felelős az adatokért, a minőségért és a javításokért. Ez különösen fontos, ha több forrásból érkeznek adatok.

### Business Rule Traceability

A nagyértékű kár üzleti szabályát és a minőségi szabályokat dokumentálni kell, hogy a riportban szereplő mutatók és logikák követhetők legyenek.

### Measure Governance

A KPI-k és a DAX measure-ek ne legyenek ad hoc módon definiálva. Fontos, hogy a mutatók neve, logikája és jelentése egyértelműen dokumentált legyen.

### Security Considerations

A Governance & Data Quality oldal is figyelembe veszi a biztonsági és adatvédelmi szempontokat, különösen a nagyértékű káradatok és a megjelenített rekordok esetében. Az oldal szerkesztése és hozzáférése legyen kontrollált.

## User Questions Answered

Az oldal segítségével a felhasználó a következő kérdésekre kap választ:

- Hány rekord van jelen a modellben?
- Mely mezőkben van a legtöbb hiányzó adat?
- Mely régiók vagy termékek érintettek adatminőségi problémákban?
- Mennyire teljes a jelenlegi adatállomány?
- Milyen mértékben megbízható az adat a riport alapjául?

## Acceptance Criteria

Az oldal akkor tekinthető megfelelőnek, ha:

- tartalmazza a Total Records KPI-t
- tartalmazza a Missing Region Records KPI-t
- tartalmazza a Missing Product Records KPI-t
- tartalmazza a Missing ClaimAmount Records KPI-t
- tartalmazza a Data Quality Score KPI-t
- tartalmazza a Missing Data Overview vizualizációt
- tartalmazza a Data Quality by Column vizualizációt
- tartalmazza a Record Completeness Distribution vizualizációt
- tartalmazza a Data Quality Trend vizualizációt
- biztosítja az adatminőségi szabályok láthatóságát
- támogatja a governance és biztonsági követelményeket
- és egyszerűen értelmezhető a döntéshozók számára.
