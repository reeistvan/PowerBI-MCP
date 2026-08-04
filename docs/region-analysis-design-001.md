# Region Analysis Design

## Business Objective

A Region Analysis oldal célja, hogy mélyebben feltárja a nagyértékű károk eloszlását régiók szerint, és lehetővé tegye a döntéshozók számára a legfontosabb régiók összehasonlítását, a trendek követését és a károk koncentrációjának azonosítását.

A fő üzleti kérdés az, hogy mely régiók jelennek meg a legnagyobb kockázati területekként, és hogyan változnak ezek az értékek az idő függvényében.

## KPI Cards

Az oldal kulcsfontosságú KPI-kártyái a következők legyenek:
- Highest Claim Amount by Region
- Highest Claim Count by Region
- Average High Value Claim by Region
- High Value Claim Count by Region
- Top Region Share of Total High Value Claims
- Latest Month High Value Claim Amount
- Current Period High Value Claim Amount

A következő két KPI-hoz szükség van az alábbi új measure-ekre:
- Max Region High Value Claim Amount
  - DAX: MAXX(VALUES(Claims[RegionName]), [High Value Claim Amount])
- Max Region High Value Claim Count
  - DAX: MAXX(VALUES(Claims[RegionName]), [High Value Claim Count])

Ezek a mutatók segítenek gyorsan azonosítani a legnagyobb és leggyorsabban változó régiókat.

## Visuals

Az oldal fő vizualizációi:
- Region comparison chart: oszlopdiagram vagy sorbarendezett oszlopdiagram a régiók közötti összehasonlításhoz.
- Region × ClaimType matrix: mátrix, ahol a sorok a régiók, az oszlopok a kártípusok, az értékek pedig a nagyértékű kárösszeg vagy darabszám.
- Trend chart: vonaldiagram az időbeli változás bemutatásához, hogy a régiók közötti trendek jól láthatóak legyenek.
- High Value Claim Count by Region: egyszerű összehasonlító diagram a nagyértékű károk darabszámának régiók szerinti megjelenítéséhez.

A vizualizációk legyenek egyszerűek, egymásra épülők és gyorsan olvashatóak.

## Filters

Az oldal használatát a következő szűrők támogatják:
- Region
- ClaimType
- Time Period
- High Value Claim Threshold

Ajánlott működés:
- A szűrők legyenek könnyen elérhetők az oldal tetején vagy bal oldalon.
- Az alapértelmezett időszak legyen következetes és üzleti szempontból releváns.
- A küszöb szűrő biztosítsa, hogy a vizualizációk mindig az 500 000 Ft feletti károkat jelenítsék meg.

## User Questions Answered

Az oldal segítségével a felhasználó a következő kérdésekre kap választ:
- Mely régiókban vannak a legnagyobb értékű károk?
- Mely régiókban a legmagasabb a nagyértékű kárdarabszám?
- Hogyan változnak a régiók teljesítményei az időben?
- Melyik régió és kártípus kombináció a legkritikusabb?
- Mely régiók dominálnak a teljes nagyértékű kárállományban?

## Acceptance Criteria

Az oldal akkor tekinthető megfelelőnek, ha:
- tartalmaz Region comparison chartot,
- tartalmaz Region × ClaimType matrixot,
- tartalmaz Trend chartot,
- megjeleníti a High Value Claim Count by Region vizualizációt,
- a KPI-kártyák egyértelműen mutatják a legfontosabb régiós teljesítményeket,
- a szűrők megfelelően alkalmazzák a nagyértékű kár logikát,
- és az oldal gyorsan és egyszerűen értelmezhető a döntéshozók számára.
