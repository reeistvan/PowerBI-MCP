# Star Schema Execution Guide

Ez az útmutató a star schema refaktor végrehajtásához nyújt részletes, lépésről lépésre követhető instrukciókat. A cél, hogy még egy junior fejlesztő is könnyen tudja követni a folyamatot.

> Először mindig készíts biztonsági másolatot a jelenlegi PBIP mappáról vagy a Power BI projektfájlról. A refaktor előtt érdemes egy új munkacsoportot vagy egy új verziót létrehozni.

## Before You Start

A jelenlegi modell forrása a Claims tábla, és a következő oszlopokkal rendelkezik:
- ClaimID
- ClaimDate
- RegionName
- ProductName
- ClaimType
- ClaimAmount

A refaktor célja, hogy ezekből létrehozzuk a következő struktúrát:
- FactClaims
- DimRegion
- DimProduct
- DimClaimType
- DimDate

## Step 1 - Create DimRegion

A DimRegion célja, hogy a régiókat külön dimenzióként kezeljük.

### 1.1. Indítsd el a Power Query szerkesztőt
- Nyisd meg a Power BI Desktopot.
- Menj a modellhez tartozó lekérdezésekhez.
- Válaszd ki a meglévő Claims lekérdezést.

### 1.2. Hozd létre a dimenzió lekérdezést
- Kattints a jobb oldali lekérdezéslistában a Claims lekérdezésre.
- Válaszd a „Duplicate” vagy „Másolat létrehozása” lehetőséget.
- A másolat nevét írd át erre: DimRegion

### 1.3. Vágd le a felesleges oszlopokat
- Maradjon csak a RegionName oszlop.
- Távolítsd el a többi oszlopot.

### 1.4. Távolítsd el a duplikációkat
- Jelöld ki a RegionName oszlopot.
- Használj Remove Duplicates műveletet.

### 1.5. Rendezd a listát
- Rendezd a RegionName oszlopot növekvő sorrendbe.

### 1.6. Add meg a kulcsot
- Adj hozzá egy új oszlopot RegionKey néven.
- Használj Index Column műveletet.
- Az index legyen 1-től induló, egész szám.

### 1.7. Nevezd át az oszlopokat
- RegionKey
- RegionName

### 1.8. Állítsd be az adattípusokat
- RegionKey: Whole Number
- RegionName: Text

### 1.9. Ellenőrizd az eredményt
A lekérdezésben csak egyedi régiónevek szerepeljenek.

## Step 2 - Create DimProduct

A DimProduct célja, hogy a termékeket külön dimenzióként kezeljük.

### 2.1. Hozd létre a másolatot
- Készíts egy új másolatot a Claims lekérdezésből.
- Nevezd el: DimProduct

### 2.2. Tartsd meg csak a termék oszlopot
- Maradjon csak a ProductName oszlop.

### 2.3. Távolítsd el a duplikációkat
- Használj Remove Duplicates műveletet a ProductName oszlopon.

### 2.4. Rendezd a listát
- Rendezd a ProductName oszlopot növekvő sorrendbe.

### 2.5. Hozz létre ProductKey-et
- Adj hozzá egy Index Column-t.
- A kulcs legyen 1, 2, 3, …

### 2.6. Nevezd át az oszlopokat
- ProductKey
- ProductName

### 2.7. Állítsd be az adattípusokat
- ProductKey: Whole Number
- ProductName: Text

## Step 3 - Create DimClaimType

A DimClaimType célja, hogy a kártípusokat külön dimenzióként kezeljük.

### 3.1. Készíts új lekérdezést
- Másold a Claims lekérdezést.
- Nevezd el: DimClaimType

### 3.2. Tartsd meg csak a kártípus oszlopot
- Maradjon csak a ClaimType oszlop.

### 3.3. Távolítsd el a duplikációkat
- Használj Remove Duplicates műveletet a ClaimType oszlopon.

### 3.4. Rendezd a listát
- Rendezd a ClaimType oszlopot növekvő sorrendbe.

### 3.5. Hozz létre ClaimTypeKey-et
- Adj hozzá egy Index Column-t.
- Az index legyen 1, 2, 3, …

### 3.6. Nevezd át az oszlopokat
- ClaimTypeKey
- ClaimType

### 3.7. Állítsd be az adattípusokat
- ClaimTypeKey: Whole Number
- ClaimType: Text

## Step 4 - Create DimDate

A DimDate célja, hogy az időalapú elemzéseket külön dimenzióból lehessen kiszolgálni.

### 4.1. Hozz létre egy új blank lekérdezést
- Kattints jobb gombbal a lekérdezések listájára.
- Válassz Blank Query lehetőséget.
- Nevezd el: DimDate

### 4.2. Írd be az M-kódot
A következő M-kód létrehoz egy teljes naptár dimenziót a Claims lekérdezés dátumai alapján:

```powerquery
let
    Source = Claims,
    MinDate = List.Min(Source[ClaimDate]),
    MaxDate = List.Max(Source[ClaimDate]),
    DateList = List.Dates(MinDate, Number.From(Duration.Days(MaxDate - MinDate)) + 1, #duration(1,0,0,0)),
    ConvertedTable = Table.FromList(DateList, Splitter.SplitByNothing(), {"Date"}),
    AddedDateKey = Table.AddColumn(ConvertedTable, "DateKey", each Date.ToText([Date], "yyyyMMdd"), type text),
    AddedYear = Table.AddColumn(AddedDateKey, "Year", each Date.Year([Date]), Int64.Type),
    AddedQuarter = Table.AddColumn(AddedYear, "Quarter", each Date.QuarterOfYear([Date]), Int64.Type),
    AddedMonth = Table.AddColumn(AddedQuarter, "Month", each Date.Month([Date]), Int64.Type),
    AddedMonthName = Table.AddColumn(AddedMonth, "MonthName", each Date.MonthName([Date]), type text),
    AddedWeek = Table.AddColumn(AddedMonthName, "Week", each Date.WeekOfYear([Date]), Int64.Type),
    AddedWeekday = Table.AddColumn(AddedWeek, "Weekday", each Date.DayOfWeek([Date]), Int64.Type),
    AddedIsWeekend = Table.AddColumn(AddedWeekday, "IsWeekend", each if [Weekday] = 5 or [Weekday] = 6 then true else false, type logical)
in
    AddedIsWeekend
```

### 4.3. Tedd használhatóvá a dimenziót
- Állítsd be a Date oszlop adattípusát dátumra.
- Állítsd be a DateKey adattípusát szövegre.
- A többi oszlopot formázd megfelelően.

### 4.4. Fontos megjegyzés
Ha a modellben már van egy jól működő Date table, akkor azt is használhatod DimDate helyett. A fontos, hogy az idődimenzió legyen teljes és konzisztens.

## Step 5 - Build FactClaims

A FactClaims a refaktor központi ténytáblája.

### 5.1. Hozd létre a FactClaims lekérdezést
- Készíts egy új lekérdezést a Claims mintájára.
- Nevezd el: FactClaims

### 5.2. Tartsd meg a tranzakciós oszlopokat
Maradjon benn:
- ClaimID
- ClaimDate
- ClaimAmount

### 5.3. Add hozzá a dimenziós kulcsokat
- Hozz létre egy RegionKey oszlopot.
- Hozz létre egy ProductKey oszlopot.
- Hozz létre egy ClaimTypeKey oszlopot.
- Hozz létre egy DateKey oszlopot.

### 5.4. Készítsd el a kulcsok összerendelését Power Queryban
Az egyes dimenziókhoz használd a Merge Queries funkciót.

1. Merge Queries a Claims és DimRegion között.
   - Join kind: Left Outer
   - Kapcsolási kulcs: RegionName
   - Expand: RegionKey
2. Merge Queries a Claims és DimProduct között.
   - Join kind: Left Outer
   - Kapcsolási kulcs: ProductName
   - Expand: ProductKey
3. Merge Queries a Claims és DimClaimType között.
   - Join kind: Left Outer
   - Kapcsolási kulcs: ClaimType
   - Expand: ClaimTypeKey
4. Merge Queries a Claims és DimDate között.
   - Join kind: Left Outer
   - Kapcsolási kulcs: ClaimDate = Date
   - Expand: DateKey

### 5.5. Add hozzá az IsHighValue mezőt
- Hozz létre egy új oszlopot IsHighValue néven.
- A feltétel: ClaimAmount > 500000

### 5.6. Ellenőrizd a grain-t
A FactClaims-ben egy sor legyen egy kárrekord.

## Step 6 - Create Relationships

### 6.1. Nyisd meg a Model view-ot
- Menj a modell nézetbe.
- Lásd a létrehozott táblákat.

### 6.2. Hozz létre a kapcsolatokat
- FactClaims[DateKey] → DimDate[DateKey]
- FactClaims[RegionKey] → DimRegion[RegionKey]
- FactClaims[ProductKey] → DimProduct[ProductKey]
- FactClaims[ClaimTypeKey] → DimClaimType[ClaimTypeKey]

### 6.3. Használj egyirányú kapcsolatokat
- A dimenziók legyenek a szűrő oldal.
- A FactClaims legyen a számláló oldal.

## Step 7 - Validate Measures

### 7.1. Ellenőrizd a meglévő méréseket
A következő mérések legyenek jelen:
- Total Claim Amount
- High Value Claim Amount
- High Value Claim Count
- High Value Claim Ratio
- Average High Value Claim

### 7.2. Frissítsd a DAX logikát, ha szükséges
A mérések alapja legyen a FactClaims tábla.

```dax
Total Claim Amount = SUM(FactClaims[ClaimAmount])
```

```dax
High Value Claim Amount = CALCULATE(SUM(FactClaims[ClaimAmount]), FactClaims[ClaimAmount] > 500000)
```

```dax
High Value Claim Count = CALCULATE(COUNTROWS(FactClaims), FactClaims[ClaimAmount] > 500000)
```

```dax
High Value Claim Ratio = DIVIDE([High Value Claim Amount], [Total Claim Amount], 0)
```

```dax
Average High Value Claim = CALCULATE(AVERAGE(FactClaims[ClaimAmount]), FactClaims[ClaimAmount] > 500000)
```

### 7.3. Ellenőrizd a dimenziók szerinti szűrést
- Régió szerinti szűrés
- Termék szerinti szűrés
- Idő szerinti szűrés
- Kártípus szerinti szűrés

## Step 8 - Validate Reports

### 8.1. Ellenőrizd az Executive Summary oldalt
- A nagyértékű károk összege helyes-e?
- A darabszám helyes-e?
- A szűrők működnek-e?

### 8.2. Ellenőrizd a Region Analysis oldalt
- A régió szerinti csoportosítás helyes-e?
- A kapcsolatok működnek-e?

### 8.3. Ellenőrizd a Product Analysis oldalt
- A termék szerinti összehasonlítás helyes-e?
- A vizualizációk és a szűrők konzisztens eredményt adnak-e?

## Rollback Instructions

Ha a refaktor során hiba történik, akkor a következő módon lehet visszalépni:

1. Mentsd el a jelenlegi modell állapotát.
2. Ne töröld el a régi Claims alapú lekérdezéseket azonnal.
3. Ha hibát találsz, állítsd vissza az előző modellverziót.
4. A méréseket és a riportokat a régi változathoz térítsd vissza, ha szükséges.
5. Dokumentáld a hibát és a javítás lépéseit.

## Validation Checklist

- [ ] A DimRegion lekérdezés létrejött.
- [ ] A DimProduct lekérdezés létrejött.
- [ ] A DimClaimType lekérdezés létrejött.
- [ ] A DimDate lekérdezés létrejött.
- [ ] A FactClaims lekérdezés létrejött.
- [ ] A kapcsolatok létrejöttek.
- [ ] A mérések a FactClaims alapján működnek.
- [ ] A riportok továbbra is helyes eredményeket mutatnak.
- [ ] A modellel kapcsolatban dokumentálták a változásokat.
