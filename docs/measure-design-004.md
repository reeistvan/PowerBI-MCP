# Measure Design

## Source Table

- Claims

## Available Columns

- ClaimID
- ClaimDate
- RegionName
- ProductName
- ClaimType
- ClaimAmount

## Recommended Measures

### 1. Total Claim Amount

### Business Purpose
- Az összes kárösszeg áttekintéséhez.

### Formula Logic
- Az összes Claims sor ClaimAmount mezőjének összege.

### DAX Formula
```dax
Total Claim Amount =
SUM(Claims[ClaimAmount])
```

### Validation Rules
- Az összes rekordot tartalmazza.
- Nem szűr a 500 000 Ft feletti küszöbre.
- Formátum: Currency

### 2. High Value Claim Amount

### Business Purpose
- A nagyértékű károk összegének megjelenítéséhez.

### Formula Logic
- Csak az 500 000 Ft feletti ClaimAmount értékek összege.

### DAX Formula
```dax
High Value Claim Amount =
CALCULATE(
    SUM(Claims[ClaimAmount]),
    Claims[ClaimAmount] > 500000
)
```

### Validation Rules
- Csak a 500 000 Ft feletti tételek szerepelnek benne.
- A mérték nem tartalmazhat 500 000 Ft vagy annál kisebb értékeket.
- Formátum: Currency

### 3. High Value Claim Count

### Business Purpose
- A nagyértékű károk darabszámának megjelenítéséhez.

### Formula Logic
- A 500 000 Ft feletti rekordok száma.

### DAX Formula
```dax
High Value Claim Count =
CALCULATE(
    COUNTROWS(Claims),
    Claims[ClaimAmount] > 500000
)
```

### Validation Rules
- Csak a 500 000 Ft feletti rekordokat számolja.
- A darabszám egész szám legyen.
- Formátum: Whole Number

### 4. High Value Claim Ratio

### Business Purpose
- A nagyértékű károk arányának megjelenítéséhez az összes károhoz viszonyítva.

### Formula Logic
- Nagyértékű kárösszeg osztva összes kárösszeggel.

### DAX Formula
```dax
High Value Claim Ratio =
DIVIDE(
    [High Value Claim Amount],
    [Total Claim Amount],
    0
)
```

### Validation Rules
- Az arány 0 és 1 között legyen.
- Ha nincs összes kárösszeg, akkor 0 legyen.
- Formátum: Percentage
- Tizedesjegyek: 1 vagy 2

### 5. Average High Value Claim

### Business Purpose
- A nagyértékű károk átlagos nagyságának megjelenítéséhez.

### Formula Logic
- A nagyértékű rekordok átlagos ClaimAmount értéke.

### DAX Formula
```dax
Average High Value Claim =
CALCULATE(
    AVERAGE(Claims[ClaimAmount]),
    Claims[ClaimAmount] > 500000
)
```

### Validation Rules
- Csak a nagyértékű rekordokból számoljon.
- Ha nincs nagyértékű rekord, akkor 0 legyen.
- Formátum: Currency
