# Dimension Build Guide

## Step 1 - Create DimRegion

### 1. Claims lekérdezés kiválasztása
- Nyisd meg a Power Query Editor-t.
- A bal oldali lekérdezéslistában válaszd ki a Claims lekérdezést.
- Ez lesz az alapforrás, ahonnan a dimenziót létrehozzuk.

### 2. Reference létrehozása
- Kattints a Claims lekérdezésre a jobb gombbal.
- Válaszd a Reference lehetőséget.
- Ezzel létrehozol egy új lekérdezést, amely az eredeti Claims lekérdezés alapján indul, de függetlenül módosítható.

### 3. Átnevezés DimRegion-re
- Az új lekérdezés neve legyen DimRegion.
- Ez a lépés fontos, mert a későbbiekben egyértelműen látszik, hogy ez a régiódimenzió.

### 4. Csak RegionName oszlop megtartása
- A Power Query ablakban töröld az összes oszlopot, kivéve a RegionName oszlopot.
- A maradék táblának csak egy oszlopa legyen: RegionName.

### 5. Remove Duplicates
- Jelöld ki a RegionName oszlopot.
- Válaszd a Remove Duplicates műveletet.
- Ennek célja, hogy csak egyetlen rekord maradjon egy-egy régióból.

### 6. Index Column hozzáadása
- Menj a Home fülre.
- Válaszd az Index Column lehetőséget.
- Válassz egy 1-től induló indexet.
- Ez lesz a dimenzió kulcsa.

### 7. Index átnevezése RegionKey-re
- Az új oszlop neve legyen RegionKey.
- A korábbi index oszlop nevét cseréld le erre.

### 8. Oszlopsorrend rendezése
- Helyezd előre a RegionKey oszlopot.
- A végső sorrend legyen:
  - RegionKey
  - RegionName

### 9. Várt eredmény
A DimRegion lekérdezésből a következő szerkezetű tábla kell, hogy legyen:

```text
RegionKey | RegionName
1         | Budapest
2         | Dél
3         | Észak
4         | Kelet
5         | Nyugat
```

## Step 2 - Create DimProduct

### 1. Claims → Reference
- A Claims lekérdezésből hozz létre egy új Reference-t.
- Az új lekérdezés neve legyen DimProduct.

### 2. Átnevezés DimProduct-re
- A lekérdezés nevét cseréld le DimProduct-re.
- Így egyértelműen látszik, hogy a termékdimenzióról van szó.

### 3. ProductName megtartása
- Tartsd meg csak a ProductName oszlopot.
- A többi oszlopot töröld el.

### 4. Remove Duplicates
- Jelöld ki a ProductName oszlopot.
- Használj Remove Duplicates műveletet.
- Ennek következtében csak egyedi terméknevek maradnak.

### 5. Index hozzáadása
- Adj hozzá új index oszlopot.
- Az index kezdőértéke legyen 1.

### 6. ProductKey kialakítása
- Az új index oszlop nevét változtasd meg ProductKey-re.
- Ez lesz a termékdimenzió kulcsa.

### 7. Oszlopsorrend rendezése
- Helyezd előre a ProductKey oszlopot.
- A végső oszlopok:
  - ProductKey
  - ProductName

### 8. Várt eredmény
A DimProduct lekérdezésből a következő szerkezetű tábla kell, hogy legyen:

```text
ProductKey | ProductName
1          | Casco
2          | Lakás
3          | Utas
4          | Vállalati
```

## Step 3 - Create DimClaimType

### 1. Claims → Reference
- A Claims lekérdezésből hozz létre egy új Reference-t.
- Az új lekérdezés neve legyen DimClaimType.

### 2. Átnevezés DimClaimType-ra
- A lekérdezés nevét cseréld le DimClaimType-ra.
- Ez a kártípusdimenzió lesz.

### 3. ClaimType megtartása
- Tartsd meg csak a ClaimType oszlopot.
- Töröld el a többi oszlopot.

### 4. Remove Duplicates
- Jelöld ki a ClaimType oszlopot.
- Használj Remove Duplicates műveletet.
- Így csak egyedi kártípusok maradnak.

### 5. Index hozzáadása
- Adj hozzá új index oszlopot.
- Az index kezdőértéke legyen 1.

### 6. ClaimTypeKey kialakítása
- Az új index oszlop nevét változtasd meg ClaimTypeKey-re.
- Ez lesz a kártípusdimenzió kulcsa.

### 7. Oszlopsorrend rendezése
- Helyezd előre a ClaimTypeKey oszlopot.
- A végső oszlopok:
  - ClaimTypeKey
  - ClaimType

### 8. Várt eredmény
A DimClaimType lekérdezésből a következő szerkezetű tábla kell, hogy legyen:

```text
ClaimTypeKey | ClaimType
1            | Baleset
2            | Elemi kár
3            | Lopás
```

## Validation Checklist

Az alábbi pontokat mind ellenőrizni kell:

- DimRegion rekordszám
- DimProduct rekordszám
- DimClaimType rekordszám
- nincsenek duplikátumok
- kulcsok egyediek
- nincsenek üres értékek

### Ellenőrzési szempontok
- A DimRegion-ben minden régió csak egyszer szerepel.
- A DimProduct-ben minden termék csak egyszer szerepel.
- A DimClaimType-ben minden kártípus csak egyszer szerepel.
- A RegionKey, ProductKey és ClaimTypeKey értékei egyediek.
- A dimenziókban nincs üres RegionName, ProductName vagy ClaimType.

## Expected Result

A modell tartalmazza a következő objektumokat:

- Claims
- DimRegion
- DimProduct
- DimClaimType

Jelen fázisban még nem kerülnek kialakításra kapcsolatok.

## Next Step

A következő sprintben a következők kerülnek megvalósításra:

- DimDate létrehozása
- FactClaims kialakítása
- Relationship Design implementálása
