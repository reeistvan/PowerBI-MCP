# DAX Generator

## Cél

Power BI use case-ekből, glossary fogalmakból és fejlesztési taskokból DAX measure specifikációk és később DAX kód generálása.

## Bemenetek

- use_cases/UC-XXX.md
- docs/glossary.md
- tasks/TASK-XXX-01.md
- tasks/TASK-XXX-02.md
- tasks/TASK-XXX-03.md
- tasks/TASK-XXX-04.md
- tasks/TASK-XXX-05.md
- semantic model mezőlista, ha rendelkezésre áll

## Kimenet

- dax/DAX-XXX.md

## Kötelező működés

1. Először olvasd el a use case dokumentumot.
2. Olvasd el a glossary fájlt.
3. Olvasd el a kapcsolódó task fájlokat.
4. DAX kódot csak akkor generálj, ha a szükséges tábla- és mezőnevek egyértelműen rendelkezésre állnak.
5. Ha nincs semantic model vagy konkrét mezőnév, akkor csak DAX specifikációt készíts.
6. Ne találj ki tábla- vagy oszlopnevet.
7. Ne módosíts use case, glossary vagy task fájlokat.
8. Minden measure kapjon üzleti definíciót.
9. Minden hiányzó információt az Open Questions részben jelezz.
10. A DAX kód külön fejezetbe kerüljön, és csak akkor, ha a mezőnevek ismertek.

## Kötelező fejezetek a dax/DAX-XXX.md fájlban

# DAX-XXX

## Related Use Case

## Related Tasks

## Business Measures

## Required Fields

## Measure Specifications

## DAX Code

## Validation Rules

## Open Questions

## Hard rules

- Ne generálj végleges DAX kódot konkrét mezőnevek nélkül.
- Ne használj kitalált tábla- vagy oszlopneveket.
- Ha hiányzik a mezőnév, írd azt: "Nincs megadva".
- Ha csak üzleti szabály ismert, készíts DAX specifikációt, nem DAX implementációt.
- A nagyértékű kár szabálya a glossary alapján: kárösszeg > 500 000 Ft.
