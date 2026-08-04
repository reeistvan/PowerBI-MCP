# Model Gap Analysis

## Existing Physical Model

- A jelenlegi fizikai modell egyetlen importált ténytáblát tartalmaz: Claims.
- A Claims tábla a data/Claims.csv fájlból töltődik be.
- A modellben van egy automatikus időbázisú dátum táblája is, valamint egy helyi dátumtábla a ClaimDate kapcsolathoz.
- A jelenlegi modell nem tartalmaz külön DimRegion, DimProduct, DimDate logikai táblákat; ezek helyett egyszerű szöveges dimenziós oszlopok jelennek meg a Claims táblában.

## Planned Logical Model

- A tervezett logikai modell egy klasszikus star schema alapján épülne:
  - FactClaims ténytábla
  - DimRegion dimenzió
  - DimProduct dimenzió
  - DimDate dimenzió
- A tervezett modellben:
  - a ténytábla tartalmazza a kárösszeget és a kapcsolatokat,
  - a dimenziók üzleti attribútumokat tartalmaznak,
  - a kapcsolatok kulcsalapúak és külön, strukturált dimenziók között valósulnak meg.

## Existing Tables

- Claims

## Existing Columns

- Claims.ClaimID
- Claims.ClaimDate
- Claims.RegionName
- Claims.ProductName
- Claims.ClaimType
- Claims.ClaimAmount

## Missing Tables

- FactClaims
- DimRegion
- DimProduct
- DimDate

## Missing Columns

- FactClaims-ben:
  - ClaimId
  - ClaimDate
  - ClaimAmount
  - RegionKey
  - ProductKey
  - DateKey
- DimRegion-ben:
  - RegionKey
  - RegionName
- DimProduct-ben:
  - ProductKey
  - ProductName
- DimDate-ben:
  - DateKey
  - Date
  - Year
  - Quarter
  - Month
  - Week

## Missing Relationships

- Claims → DimRegion kapcsolat nincs megvalósítva.
- Claims → DimProduct kapcsolat nincs megvalósítva.
- Claims → DimDate kapcsolat nincs megvalósítva.
- A jelenlegi modellben a régió, termék és dátum csak oszlopként szerepel a Claims táblában, nem külön dimenziókon keresztül.

## Missing Measures

- Nagyértékű kárösszeg
- Nagyértékű károk darabszáma
- Összes kárösszeg
- Nagyértékű károk aránya

## Recommendations

### Must Have
- A jelenlegi Claims táblát strukturáltan fel kell bontani FactClaims + dimenziók szerint.
- A régió, termék és dátum dimenziók külön táblákba rendezése.
- A nagyértékű kár üzleti szabályának explicit dokumentálása és measure formában történő megvalósítása.

### Should Have
- Surrogate key stratégia bevezetése a dimenziókhoz.
- Date dimension használata a vizualizációk és időbontások támogatására.
- A modell átalakítása star schema irányába.

### Nice To Have
- IsHighValue számított oszlop vagy DAX logika bevezetése.
- További dimenziók és KPI-k bővítése a jövőbeli igényekhez.
