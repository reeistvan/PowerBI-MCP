# Star Schema Refactor Design

> Ez a dokumentum jelenleg csak tervezetként jelenik meg. A célja a jelenlegi Claims alapú modell átstrukturálásának koncepciójának rögzítése, anélkül hogy a Power BI fájlokat módosítanánk.

## Current Model

A jelenlegi modell egyetlen, importált Claims táblára épül. A tábla közvetlenül tartalmazza a káradatokat és a dimenziós információkat is, így a régió, a termék, a kártípus és az idő nem külön dimenziókban, hanem szöveges oszlopként jelennek meg a tranzakciós táblában.

### Jelenlegi jellemzők
- Fő forrás: Claims
- Fő üzleti entitás: egy kárrekord / egy kártranzakció
- Jelenlegi oszlopok:
  - ClaimID
  - ClaimDate
  - RegionName
  - ProductName
  - ClaimType
  - ClaimAmount
- Hátrányok:
  - a dimenziós logika nem különül el a tényadatoktól
  - a kapcsolatok nem strukturáltak
  - a későbbi bővítés és a riportfejlesztés nehezebbé válik
  - a DAX logika és a governance szabályok nehezebben nyomon követhetők

## Target Model

A célállapot egy klasszikus star schema, ahol a központi ténytábla a kártranzakciókat tartalmazza, a dimenziók pedig külön táblákban reprezentálják az üzleti szegmentációkat.

### Célmodell elemei
- FactClaims
- DimDate
- DimRegion
- DimProduct
- DimClaimType

### Célmodell főelvei
- egy központi ténytábla
- dimenziók külön, jól definiált kulcsokkal
- egyszerű, egyirányú kapcsolatok a ténytábla és a dimenziók között
- jobb bővíthetőség és jobb riportolhatóság

## Fact Table Design

A FactClaims tábla a fő tranzakciós szintű entitás lesz.

### Javasolt mezők
- ClaimId
- ClaimDate
- ClaimAmount
- RegionKey
- ProductKey
- DateKey
- ClaimTypeKey
- IsHighValue (opcionális, számított oszlop vagy DAX logika)
- SourceSystem (opcionális)
- Currency (opcionális)

### Megjegyzés
- A grain javasolt szintje: egy sor = egy kárrekord / egy kártranzakció.
- A ClaimAmount a fő pénzügyi mérőszám.
- A nagyértékű kár üzleti szabálya továbbra is a ClaimAmount > 500000 feltétel alapján értelmezendő.

## Dimension Design

### DimDate

A DimDate a riportok időalapú szegmentálásához szolgál.

#### Javasolt mezők
- DateKey
- Date
- Year
- Quarter
- Month
- MonthName
- Week
- Weekday
- IsWeekend

### DimRegion

A DimRegion a régió szerinti elemzések alapja.

#### Javasolt mezők
- RegionKey
- RegionName
- RegionGroup (opcionális)
- Country (opcionális)
- Area (opcionális)

### DimProduct

A DimProduct a termék szerinti elemzések alapja.

#### Javasolt mezők
- ProductKey
- ProductName
- ProductCategory (opcionális)
- ProductGroup (opcionális)

### DimClaimType

A DimClaimType a kár típus szerinti elemzésekhez nyújt támogatást.

#### Javasolt mezők
- ClaimTypeKey
- ClaimType
- ClaimTypeGroup (opcionális)
- ClaimTypeDescription (opcionális)

## Relationship Design

A kapcsolatok a star schema logikája szerint épülnek fel.

### FactClaims → DimDate
- FactClaims[DateKey] → DimDate[DateKey]
- Cél: időalapú szűrés és trendelemzés

### FactClaims → DimRegion
- FactClaims[RegionKey] → DimRegion[RegionKey]
- Cél: régió szerinti aggregáció és elemzés

### FactClaims → DimProduct
- FactClaims[ProductKey] → DimProduct[ProductKey]
- Cél: termék szerinti aggregáció és összehasonlítás

### FactClaims → DimClaimType
- FactClaims[ClaimTypeKey] → DimClaimType[ClaimTypeKey]
- Cél: kártípus szerinti szeletelés és vizualizáció

## Migration Steps

### 1. Claims tábla elemzése
- A jelenlegi Claims tábla oszlopait és tartalmát át kell tekinteni.
- Meg kell határozni, hogy mely mezők ténylegesen dimenziós attribútumok, és melyek tényleges tranzakciós értékek.
- Ellenőrizni kell a hiányzó értékeket és a duplikációs kockázatokat.

### 2. Dimenziók létrehozása
- Létre kell hozni a DimDate, DimRegion, DimProduct és DimClaimType táblákat.
- Minden dimenzióban egyértelmű, stabil kulcsot kell bevezetni.
- A dimenziók tartalmazzák az üzleti attribútumokat, nem pedig a tranzakciós mérőszámokat.

### 3. Kulcsok kialakítása
- A dimenziókhoz surrogate keyokat érdemes használni.
- A forrásrendszerben meglévő üzleti azonosítók dokumentálásra kerülnek.
- A kapcsolatok konzisztens és egyértelmű módon épülnek fel.

### 4. FactClaims létrehozása
- A ténytáblába átkerülnek a tranzakciós mezők:
  - ClaimId
  - ClaimAmount
  - DateKey
  - RegionKey
  - ProductKey
  - ClaimTypeKey
- A nagyértékű kár üzleti szabályát a modellben következetesen kell alkalmazni.

### 5. Kapcsolatok kialakítása
- A FactClaims és a dimenziók közötti kapcsolatok létrehozása.
- A kapcsolatokat egyszerű, egyirányú, jól olvasható formában kell definiálni.
- A kapcsolatok célja a dimenzió szerinti szeletelés és aggregáció támogatása.

### 6. Measure-ek újratesztelése
- A meglévő measure-eket újra kell ellenőrizni a star schema alapján.
- A következő mérések különösen fontosak:
  - Total Claim Amount
  - High Value Claim Amount
  - High Value Claim Count
  - High Value Claim Ratio
  - Average High Value Claim
- Ellenőrizni kell, hogy a mérések a megfelelő táblákból és kapcsolatokból dolgoznak.

### 7. Riport validálása
- A riportokban ellenőrizni kell a vizualizációk és a szűrők helyes működését.
- A dimenziók és a ténytábla közötti kapcsolatok alapján meg kell nézni, hogy a szűrés és a csoportosítás helyes-e.
- A nagyértékű kár szabálya a riportban is következetes legyen.

## Risks

- A forrásadat grainjának bizonytalansága.
- A meglévő Claims adatokból származó dimenzióattribútumok hiányos vagy inkonzisztens adatállapota.
- A dimenziók kulcsainak konzisztens kezelése.
- A jelenlegi modell és a jövőbeli star schema közötti átmeneti zavarok.
- A DAX measure-ek újraértékelésének szükségessége a kapcsolatok módosulása után.

## Expected Benefits

- jobb olvashatóság és karbantarthatóság
- jobb riportfejlesztési élmény
- egyszerűbb dimenziós szeletelés és aggregáció
- jobb skálázhatóság nagyobb adatmennyiség esetén
- jobb auditálhatóság és governance támogatás
- egyértelműbb üzleti szabályok és mérések

## Acceptance Criteria

A refaktor tervezet akkor tekinthető elfogadhatónak, ha:
- a jelenlegi Claims modell jól dokumentált
- a célállapot egyértelműen meghatározott
- a FactClaims és a dimenziók szerepe és mezői világosak
- a kapcsolatok logikája követhető
- a migrációs lépések sorrendben és végrehajthatóan meg vannak írva
- a tervezet nem igényli a Power BI fájlok módosítását
