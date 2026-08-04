# Data Model Design

## Fact Tables

### FactClaims
- Cél: A károk tranzakciós szintű rögzítésére szolgál.
- Javasolt tartalom:
  - ClaimId (üzleti azonosító)
  - ClaimDate
  - ClaimAmount
  - RegionKey (idegen kulcs)
  - ProductKey (idegen kulcs)
  - DateKey (idegen kulcs)
  - IsHighValue (opcionális, számított oszlopként vagy DAX logikában előállítható)
  - Optional: ClaimType, Currency, SourceSystem
- Üzleti szerep: A nagyértékű károk elemzésének fő ténytáblája.

## Dimension Tables

### DimRegion
- Cél: Régió szerinti szeletelés és csoportosítás.
- Javasolt tartalom:
  - RegionKey (technikai, surrogate kulcs)
  - RegionName (üzleti attribútum)
  - Optional: RegionGroup, Country, Area

### DimProduct
- Cél: Termék szerinti szeletelés és csoportosítás.
- Javasolt tartalom:
  - ProductKey (technikai, surrogate kulcs)
  - ProductName (üzleti attribútum)
  - Optional: ProductCategory, ProductGroup

### DimDate
- Cél: Időszak szerinti szűrés és elemzés.
- Javasolt tartalom:
  - DateKey (technikai kulcs)
  - Date (üzleti attribútum)
  - Year
  - Quarter
  - Month
  - Week

## Relationships

- FactClaims[RegionKey] → DimRegion[RegionKey]
- FactClaims[ProductKey] → DimProduct[ProductKey]
- FactClaims[DateKey] → DimDate[DateKey]
- A kapcsolatokat egy klasszikus star schema szerint javaslom, ahol a ténytábla a centrum, a dimenziók pedig körülötte helyezkednek el.

## Grain

- Javasolt grain: egy sor = egy kártranzakció / egy kár rekordja.
- Ez lehetővé teszi, hogy a riportban:
  - kárösszeg szerint aggregáljunk,
  - régió és termék szerint szegmentáljunk,
  - a nagyértékű küszöböt logikailag alkalmazzuk.

### Grain Validation
- Egy rekord egy káreseményt reprezentál.
- A ClaimAmount a rekord teljes kárösszegét tartalmazza.
- A Region és Product dimenziók a rekordhoz egyértelműen hozzárendelhetők.
- A grain nem aggregált szintű adat.

## Business Mapping

- Kárösszeg: a FactClaims ténytábla ClaimAmount mezője.
- Nagyértékű kár üzleti definíció: ClaimAmount > 500000.
- Régió: a DimRegion dimenzióból származik.
- Termék: a DimProduct dimenzióból származik.
- Idő: a DimDate dimenzióból származik a riport szűréséhez.
- IsHighValue mező: opcionális, számított oszlopként vagy DAX logikában is előállítható.

## Recommended Measures

- Nagyértékű kárösszeg
  - Számítása: ClaimAmount összegzése, csak a ClaimAmount > 500000 rekordok esetén.
- Nagyértékű károk darabszáma
  - Számítása: a nagyértékű rekordok darabszáma.
- Összes kárösszeg
  - Segít összehasonlítani a nagyértékű károkat az összes kárhoz képest.
- Nagyértékű károk aránya
  - Opcionális KPI, ha a döntéshozók részletes arányszámot szeretnének látni.

## Model Design Principles

- Star schema használata.
- Egy központi ténytábla.
- Egyszeres irányú kapcsolatok preferálása.
- Dimenziók újrafelhasználhatósága.
- Date dimension kötelező használata időalapú elemzésekhez.
- Üzleti szabályok dokumentálása, nem fizikai tárolása, ahol lehetséges.

## Open Questions

- Melyek a pontos mezőnevek a forrásadatokban a régió, termék, kárösszeg és dátum esetén?
- Van-e a forrásadatban több pénznem vagy több valuta?
- Szükséges-e további dimenzió, például károsztály, szerződéstípus vagy ügyfélkategória?
- Kell-e sor szintű biztonsági szabály a káradatokhoz?
- A forrásadatok szintje claim szintű, vagy sor szintű (pl. kártételek) legyen?
