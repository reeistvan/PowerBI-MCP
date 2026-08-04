# Product Analysis Design

## Business Objective

A Product Analysis oldal célja, hogy feltárja a nagyértékű károk termék szerinti megoszlását, és lehetővé tegye a döntéshozók számára a legfontosabb termékek összehasonlítását, trendjeinek követését és a kockázatok koncentrációjának azonosítását.

A fő üzleti kérdés az, hogy mely termékek jelennek meg a legnagyobb kockázati területekként, és hogyan változnak ezek az értékek az idő függvényében.

## KPI Cards

Az oldal kulcsfontosságú KPI-kártyái a következők legyenek:
- Top Product
- Top Product Amount
- Top Product Claim Count
- Average High Value Claim by Product
- Product Share of Total High Value Claims
- Latest Month High Value Claim Amount by Product

Ezek a mutatók segítenek gyorsan azonosítani a legnagyobb és leggyorsabban változó termékeket.

## Visuals

### Product Comparison Chart

Axis:
- ProductName

Value:
- High Value Claim Amount

Ez a vizualizáció egy oszlopdiagram vagy rendezett oszlopdiagram formájában mutatja be a termékek közötti összehasonlítást.

### Product × ClaimType Matrix

Rows:
- ProductName

Columns:
- ClaimType

Values:
- High Value Claim Amount

Ez a mátrix lehetővé teszi a termékek és a kártípusok közötti metszetvizsgálatot, és segít azonosítani a legkritikusabb kombinációkat.

### Product Trend Chart

Axis:
- ClaimDate

Values:
- High Value Claim Amount

Ez a vizualizáció a termékek időbeli változását mutatja, így követhetővé válik, hogy egy adott termék hogyan fejlődik az időben.

### High Value Claim Count by Product

Axis:
- ProductName

Values:
- High Value Claim Count

Ez a vizualizáció a nagyértékű károk darabszámát jeleníti meg termékek szerinti bontásban.

## Filters

Az oldal használatát a következő szűrők támogatják:
- ProductName
- ClaimType
- Time Period
- High Value Claim Threshold

Ajánlott működés:
- A szűrők legyenek könnyen elérhetők az oldal tetején vagy bal oldalon.
- Az alapértelmezett időszak legyen következetes és üzleti szempontból releváns.
- A küszöb szűrő biztosítsa, hogy a vizualizációk mindig az 500 000 Ft feletti károkat jelenítsék meg.

## User Questions Answered

Az oldal segítségével a felhasználó a következő kérdésekre kap választ:
- Mely termékekben vannak a legnagyobb értékű károk?
- Mely termékekben a legmagasabb a nagyértékű kárdarabszám?
- Hogyan változnak a termékek teljesítményei az időben?
- Melyik termék és kártípus kombináció a legkritikusabb?
- Mely termékek dominálnak a teljes nagyértékű kárállományban?

## Acceptance Criteria

Az oldal akkor tekinthető megfelelőnek, ha:
- tartalmaz Product Comparison Chartot,
- tartalmaz Product × ClaimType Matrixot,
- tartalmaz Product Trend Chartot,
- megjeleníti a High Value Claim Count by Product vizualizációt,
- a KPI-kártyák egyértelműen mutatják a legfontosabb termék szerinti teljesítményeket,
- a szűrők megfelelően alkalmazzák a nagyértékű kár logikát,
- és az oldal gyorsan és egyszerűen értelmezhető a döntéshozók számára.
