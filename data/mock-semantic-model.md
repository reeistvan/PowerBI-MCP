# Mock Semantic Model

## Cél

Ez a fájl egy oktatási célú minta semantic model leírás.
A célja, hogy a DAX-Generator skill konkrét, de nem éles Power BI modell alapján tudjon DAX javaslatot készíteni.

## Tables

### FactClaims

Leírás:
Káreseményeket tartalmazó ténytábla.

Mezők:
- ClaimID
- ClaimDate
- ClaimAmount
- ProductKey
- RegionKey

### DimProduct

Leírás:
Termékdimenzió.

Mezők:
- ProductKey
- ProductName
- ProductCategory

### DimRegion

Leírás:
Régiódimenzió.

Mezők:
- RegionKey
- RegionName

## Relationships

- FactClaims[ProductKey] many-to-one DimProduct[ProductKey]
- FactClaims[RegionKey] many-to-one DimRegion[RegionKey]

## Business Mapping

- Kárösszeg = FactClaims[ClaimAmount]
- Régió = DimRegion[RegionName]
- Termék = DimProduct[ProductName]
- Nagyértékű kár szabály = FactClaims[ClaimAmount] > 500000

## Notes

Ez nem éles adatmodell.
Ez csak oktatási célú mock semantic model.
Valódi Power BI modell esetén a mezőlistát később Power BI MCP-n keresztül kell lekérdezni.
