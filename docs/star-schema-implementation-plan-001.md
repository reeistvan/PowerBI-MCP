# Star Schema Implementation Plan

> Ez a dokumentum jelenleg csak tervezetként jelenik meg. A célja egy részletes, végrehajtható implementációs terv megfogalmazása a star schema refaktorhoz, anélkül hogy a Power BI fájlokat módosítanánk.

## Current State

A jelenlegi PBIP semantikus modell egyetlen Claims nevű táblára épül. A modell tartalmazza a következő mezőket:

- ClaimID
- ClaimDate
- RegionName
- ProductName
- ClaimType
- ClaimAmount

A modelben jelenleg:
- egy importált Claims tábla található
- a ClaimDate mező egy helyi dátumtáblához kapcsolódik
- a nagyértékű kár mérések közvetlenül a Claims táblára épülnek
- nincs külön FactClaims ténytábla
- nincs külön DimDate, DimRegion, DimProduct vagy DimClaimType dimenzió
- nincsenek külön, strukturált surrogate key alapú kapcsolatok

Ez azt jelenti, hogy a jelenlegi modell inkább egy egyszerű, flat tranzakciós modell, mint egy teljes, szervezett star schema.

## Target State

A célállapot egy klasszikus star schema lesz, ahol:

- a FactClaims táblában szerepelnek a tranzakciós tényadatok
- a DimDate, DimRegion, DimProduct és DimClaimType táblák tartalmazzák az attribútumokat
- a ténytábla és a dimenziók közötti kapcsolatok kulcsalapúak
- a mérések a ténytáblára épülnek, a szeletelés pedig a dimenziók felől történik
- a riportok ugyanazt a üzleti logikát használják, de a modell tisztább, skálázhatóbb és könnyebben karbantartható lesz

### Végső célok
- egyértelmű tény/dimenzió szétválasztás
- stabil, auditálható kulcsok
- jobban követhető üzleti logika
- könnyebb bővíthetőség új dimenziók és mérések számára

## Dimension Extraction Plan

A dimenziók kinyerése a jelenlegi Claims táblából történik. A fő cél, hogy az üzleti attribútumok külön táblákba kerüljenek, míg a tranzakciós adatok a FactClaims táblában maradjanak.

### DimDate

#### Cél
A DimDate a riportok időalapú elemzésének alapja legyen.

#### Kinyerési logika
- Forrás: Claims[ClaimDate]
- A dimenzió minden egyes egyedi dátumhoz egy sort tartalmazzon.
- A dátumokból kell egy teljes, konzisztens dimenziót létrehozni.

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

#### Részletes lépések
1. Az összes egyedi ClaimDate érték összegyűjtése.
2. A dátumokból egy teljes naptár dimenzió összeállítása a minimális és maximális dátum közötti tartományra.
3. Minden dátumhoz egy stabil kulcs létrehozása, például DateKey formátumban: YYYYMMDD.
4. A következő attribútumok feltöltése:
   - év
   - negyedév
   - hónap
   - hónapnév
   - hét
   - hét napja
   - hétvége-e
5. A dimenziót úgy kell kialakítani, hogy a későbbi YTD, MTD, Previous Period és Trend vizualizációkhoz is használható legyen.

#### Adatminőségi szempontok
- üres dátumok kezelése
- érvénytelen dátumok észlelése
- dupla rekordok kizárása

### DimRegion

#### Cél
A DimRegion a régió szerinti szeletelés és aggregáció alapja legyen.

#### Kinyerési logika
- Forrás: Claims[RegionName]
- A dimenzió az egyedi régióneveket tartalmazza.

#### Javasolt mezők
- RegionKey
- RegionName
- RegionGroup (opcionális)
- Country (opcionális)
- Area (opcionális)

#### Részletes lépések
1. A Claims tábla RegionName mezőjének egyedi értékeinek listázása.
2. Minden egyedi régióhoz egy surrogate key létrehozása.
3. A RegionName attribútum feltöltése.
4. Opcionálisan további hierarchia mezők hozzáadása, ha a jövőbeli reportok ezt igénylik.
5. A hiányzó régióértékek explicit módon dokumentálása.

#### Adatminőségi szempontok
- üres régióértékek kezelése
- esetleges eltérő írásmódok egységesítése
- duplikált régiónevek kizárása

### DimProduct

#### Cél
A DimProduct a termék szerinti elemzések alapja legyen.

#### Kinyerési logika
- Forrás: Claims[ProductName]
- A dimenzió az egyedi termékneveket tartalmazza.

#### Javasolt mezők
- ProductKey
- ProductName
- ProductCategory (opcionális)
- ProductGroup (opcionális)

#### Részletes lépések
1. A Claims tábla ProductName mezőjének egyedi értékeinek listázása.
2. Minden egyedi termékhez egy surrogate key létrehozása.
3. A ProductName attribútum feltöltése.
4. Opcionálisan termékkategóriák vagy termékcsoportok hozzáadása.
5. Hiányzó vagy nem egyértelmű termékazonosítók dokumentálása.

#### Adatminőségi szempontok
- eltérő terméknevek egységesítése
- üres termékértékek kezelése
- ismétlődő terméknevek összevonása

### DimClaimType

#### Cél
A DimClaimType a kártípus szerinti szeletelés és aggregáció alapja legyen.

#### Kinyerési logika
- Forrás: Claims[ClaimType]
- A dimenzió az egyedi kártípusokat tartalmazza.

#### Javasolt mezők
- ClaimTypeKey
- ClaimType
- ClaimTypeGroup (opcionális)
- ClaimTypeDescription (opcionális)

#### Részletes lépések
1. A Claims tábla ClaimType mezőjének egyedi értékeinek listázása.
2. Minden egyedi kártípushoz egy surrogate key létrehozása.
3. A ClaimType attribútum feltöltése.
4. Opcionálisan csoportosítási mezők hozzáadása, ha a jövőbeli riportok ezt igénylik.
5. A hiányzó vagy nem szabványos kártípusok dokumentálása.

#### Adatminőségi szempontok
- eltérő kártípus névváltozatok egységesítése
- üres értékek kezelése
- ismétlődő kategóriák összevonása

## FactClaims Design

A FactClaims táblának a tranzakciós szintű információkat kell tartalmaznia.

### Javasolt grain
- egy sor = egy kártranzakció / egy kárrekord

### Javasolt mezők
- ClaimId
- ClaimDate
- ClaimAmount
- DateKey
- RegionKey
- ProductKey
- ClaimTypeKey
- IsHighValue (opcionális)
- SourceSystem (opcionális)
- Currency (opcionális)

### Részletes tervezési szempontok
1. A ténytáblában csak tranzakciós értékek legyenek, ne üzleti attribútumok.
2. A dimenziókhoz tartozó kulcsok idegen kulcsként jelenjenek meg a ténytáblában.
3. A ClaimAmount legyen a fő mérőszám, amelyet a mérések aggregálnak.
4. Az IsHighValue mező opcionálisan számított oszlopként vagy DAX logikával álljon elő.
5. A ClaimId legyen a tranzakció egyedi azonosítója, ha a forrásadatok ezt támogatják.

### Adatminőségi feltételek
- nincs üres vagy null ClaimAmount
- nincs hiányzó idegen kulcs a dimenziók felé
- minden fact sorhoz tartozzon egyértelmű dimenzió rekord

## Surrogate Key Strategy

A dimenziókhoz surrogate keyokat javasolt használni, mivel ez stabilabb és skálázhatóbb modellstruktúrát biztosít.

### Javasolt megközelítés
- Minden dimenzióhoz egy numerikus vagy sztring alapú kulcs legyen.
- A kulcsok legyenek függetlenek a forrásadatok változásaitól.
- A forrásrendszerben meglévő üzleti kulcsot külön mezőként dokumentálni kell.

### Részletes lépések
1. Minden dimenzióhoz létre kell hozni egy új kulcsmezőt.
2. A kulcsokat egyértelműen és következetesen kell generálni.
3. A ténytáblában ezek a kulcsok legyenek tárolva.
4. A forrásrendszerből származó üzleti kulcsokat meg kell őrizni auditálhatósági célból.
5. A későbbi változtatások esetén az új kulcsok ne legyenek összeomló vagy átmeneti megoldások.

### Előnyök
- könnyebb karbantartás
- jobb kapcsolati stabilitás
- egyszerűbb bővítés új attribútumokkal

## Relationship Strategy

A kapcsolatoknak a star schema logikáját kell követniük.

### Javasolt kapcsolatok
- FactClaims[DateKey] → DimDate[DateKey]
- FactClaims[RegionKey] → DimRegion[RegionKey]
- FactClaims[ProductKey] → DimProduct[ProductKey]
- FactClaims[ClaimTypeKey] → DimClaimType[ClaimTypeKey]

### Részletes szabályok
1. A kapcsolatok legyenek egyirányúak.
2. A dimenziók legyenek a „szűrő” oldal, a ténytábla pedig a „számláló” oldal.
3. Kerülni kell a kétirányú kapcsolatokat, hacsak nincs erre külön üzleti indok.
4. A kapcsolatokat egyszerűen és következetesen kell definiálni a modellben.
5. A riportokban a dimenziók felől történő szűrés legyen az elsődleges út.

### Kockázatok
- túl sok kapcsolat vagy szűrő út
- helytelen kulcsok közötti illeszkedés
- hiányzó dimenzió rekordok a fact táblában

## Measure Migration Plan

A jelenlegi mérések a Claims táblára épülnek. A refaktor után ezeket a méréseket át kell helyezni a FactClaims táblára.

### 1. Mértékszótár összeállítása
- listázni kell a meglévő measure-eket
- meg kell határozni a közös üzleti definíciókat
- dokumentálni kell, hogy melyik measure melyik dimenzió szerint szeletelhető

### 2. Jelenlegi measure-ek azonosítása
A következő mérések a legfontosabbak:
- Total Claim Amount
- High Value Claim Amount
- High Value Claim Count
- High Value Claim Ratio
- Average High Value Claim

### 3. Measure-ek újradefiniálása
A mérések alapja a FactClaims táblán legyen:

- Total Claim Amount = SUM(FactClaims[ClaimAmount])
- High Value Claim Amount = CALCULATE(SUM(FactClaims[ClaimAmount]), FactClaims[ClaimAmount] > 500000)
- High Value Claim Count = CALCULATE(COUNTROWS(FactClaims), FactClaims[ClaimAmount] > 500000)
- High Value Claim Ratio = DIVIDE([High Value Claim Amount], [Total Claim Amount], 0)
- Average High Value Claim = CALCULATE(AVERAGE(FactClaims[ClaimAmount]), FactClaims[ClaimAmount] > 500000)

### 4. Szeletelés és kontextus ellenőrzése
- a régió és termék szeletelés a dimenziókon keresztül működjön
- az idődimenzió valós időszűrést támogasson
- a meglévő riportok ugyanazt a mérőszámot jelenítsék meg, de a modell háttérben tisztább legyen

### 5. Validáció
- összehasonlítani kell az új és a régi measure-ek eredményeit
- ellenőrizni kell a részösszegek és a teljes összegek konzisztenciáját
- a nagyértékű kár küszöb szerinti szűrésnek ugyanazt az eredményt kell adnia, mint a régi modellben

## Report Impact Assessment

A riportok valószínűleg nem igényelnek teljes újratervezést, de a modellváltozásoknak közvetlen hatásuk lesz a vizualizációkra.

### Várható hatások
1. A meglévő vizualizációk továbbra is ugyanazokat a üzleti kérdéseket fedik le.
2. A szűrők és szeletelők a dimenziókon keresztül pontosabban és következetesebben fognak működni.
3. Az időalapú vizualizációk erősebbé válnak, ha DimDate kerül bevezetésre.
4. A régió és termék szerinti vizualizációk jobb kontextust kapnak a dimenzionális kapcsolatok révén.

### Lehetséges kockázatok
- régi vizualizációk a változás miatt nem jelenítik meg ugyanazt az eredményt
- a kapcsolatok miatt egyes szűrők másképp viselkednek
- a date hierarchy és a dimenzió közötti kapcsolat megváltoztathatja a riportok időbeli vizsgálatát

### Köztes megoldás
- az új modellel párhuzamosan kell tartani a régi méréseket a validáció idejére
- a riportokat fokozatosan kell frissíteni, ne egyetlen nagy átállással

## Testing Strategy

A megvalósítás előtt és után különböző teszteket kell végezni.

### 1. Strukturális tesztek
- ellenőrizni kell, hogy minden dimenzió létrejött-e
- ellenőrizni kell, hogy a fact és a dimenziók közötti kulcsok helyesek-e
- ellenőrizni kell, hogy nincs-e hiányzó vagy üres idegen kulcs

### 2. Adatminőségi tesztek
- meg kell nézni, hogy a dimenziók rekordjainak száma összhangban van-e a forrásadatokkal
- ellenőrizni kell a hiányzó értékeket
- ellenőrizni kell, hogy a dimenziókban nincs-e két különböző név ugyanarra az üzleti entitásra

### 3. Mérték tesztek
- a régi és az új measure-ek közötti összehasonlítás
- a nagyértékű küszöb szerinti szűrés ellenőrzése
- az aggregált értékek validálása különböző szűrőkontextusokban

### 4. Riporttesztek
- minden oldalon ellenőrizni kell a KPI-k megjelenését
- a régió, termék és idő alapján történő szűrés helyes működését
- a matrix és oszlopdiagram vizualizációk helyes aggregációját

### 5. Üzleti validáció
- a reportok tartalma összhangban legyen az UC-004 üzleti céljával
- a mérések legyenek könnyen értelmezhetők a döntéshozók számára

## Rollback Strategy

A rollback stratégiának biztosítania kell, hogy a refaktor ne legyen irreverzibilis.

### Részletes rollback lépések
1. A jelenlegi Claims alapú modell változatát meg kell őrizni, amíg az új modell validálva nincs.
2. Az új modellezési változtatásokat külön ág vagy külön modellszintként kell kezelni.
3. Ha a validáció során hibát találunk, a régi modellhez kell visszatérni.
4. A mérések és a reportok visszaállíthatók a régi tartalomra.
5. A rollback dokumentációban fel kell sorolni a visszaállítási lépéseket és a kritikus pontokat.

### Rollback indokai
- hibás kapcsolatok
- nem várt aggregációs különbségek
- dimenziók hiányos vagy helytelen feltöltése
- riportok működésének megváltozása

## Acceptance Criteria

A refaktor tervezet akkor tekinthető elfogadhatónak, ha a következők teljesülnek:

- a jelenlegi Claims modell pontosan dokumentált
- a célállapot egyértelműen meghatározott
- a FactClaims és a négy dimenzió létrehozásának lépései részletesen le vannak írva
- a kulcsstratégia és a kapcsolati stratégia egyértelmű
- a mérések migrációja végrehajtható és ellenőrizhető
- a riportokra gyakorolt hatás ismert és dokumentált
- a validációs és rollback folyamatok részletesen definiáltak
- a tervezet nem igényli a Power BI fájlok módosítását a jelenlegi fázisban
