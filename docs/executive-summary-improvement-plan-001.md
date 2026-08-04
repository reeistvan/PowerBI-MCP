# Executive Summary Improvement Plan

## Missing Visuals

Az Executive Summary oldalon jelenleg nem jelenik meg egy központi, gyorsan értelmezhető vizualizáció, amely a nagyértékű károkat régió és termék szerint együttesen jeleníti meg.

Javasolt vizualizációk:
- Region × Product Matrix: régiók sorokként, termékek oszlopokként, értékként a nagyértékű kárösszeggel.
- Top Region elemzés: rendezett oszlopdiagram vagy kártya a legnagyobb kárösszegű régiók megjelenítéséhez.
- Top Product elemzés: rendezett oszlopdiagram vagy kártya a legnagyobb kárösszegű termékek megjelenítéséhez.
- Összegző KPI kártyák a fő mutatókhoz, hogy az oldal első pillantásra jól olvasható legyen.

## Missing KPIs

A jelenlegi oldalhoz szükséges KPI-k prioritása a döntéshozói hasznosság alapján:

1. High Priority
   - Összes nagyértékű kárösszeg
   - Nagyértékű károk darabszáma
   - High Value Claim Ratio
   - Top Region összeg alapján
   - Top Product összeg alapján

2. Medium Priority
   - Átlagos nagyértékű kár összege
   - Régiók közötti arányos eltérés
   - Termékek közötti arányos eltérés

3. Low Priority
   - Egyéb kiegészítő trend- vagy összehasonlító mutatók

KPI prioritás összefoglalva:
- Elsődleges cél: gyorsan azonosítani a legnagyobb kockázati területeket.
- Másodlagos cél: megérteni, hogy a kockázat mely régiókban és termékekben koncentrálódik.

## Region × Product Matrix Design

A Region × Product Matrix legyen a lap központi vizualizációja.

Tervezett felépítés:
- Sorok: Régiók
- Oszlopok: Termékek
- Érték: Nagyértékű kárösszeg
- Formátum: pénznem, jól olvasható színskála
- Rendezés: csökkenő érték szerint az elsődleges fókuszterületek megjelenítéséhez

Design irányelvek:
- A matrix legyen egyszerű, ne legyen túlzsúfolt.
- A legmagasabb értékű cellák legyenek színnel kiemelve.
- A vizualizáció legyen olvasható még nagy adathalmaz esetén is.
- A matrix tetején vagy oldalt egy rövid magyarázó címke legyen, hogy az értelmezés azonnal egyértelmű legyen.

## Additional Slicers

Az oldal használhatóságának növeléséhez szükséges további szűrők:
- Régió
- Termék
- Időszak
- Nagyértékű kár küszöb (pl. > 500 000 Ft)

Ajánlott működés:
- A szűrők legyenek könnyen elérhetők az oldalon.
- Az alapértelmezett szűrő beállítás legyen következetes és üzleti szempontból logikus.
- A szűrők ne torzítsák a KPI-k értelmezhetőségét, ezért a fő KPI-k mindig ugyanazon logikával jelenjenek meg.

## Business Justification

Az Executive Summary oldal célja, hogy a döntéshozók gyorsan és egyértelműen lássák, mely régiókban és termékekben koncentrálódnak a legnagyobb értékű károk.

Ez a javítási terv közvetlenül támogatja az UC-004 üzleti célját, mert:
- gyors áttekintést nyújt a nagyértékű károk helyzetéről,
- azonosítja a legfontosabb fókuszterületeket,
- támogatja a stratégiai döntéseket és a kockázati prioritásokat,
- és egyértelműen összekapcsolja a riportot a régió- és termékalapú elemzés követelményével.

## Acceptance Criteria

Az Executive Summary oldal akkor tekinthető megfelelőnek, ha:
- szerepel rajta egy Region × Product Matrix vizualizáció,
- megjelenik Top Region elemzés és Top Product elemzés,
- a fő KPI-k prioritált sorrendben jelennek meg,
- az oldal tartalmazza a régió, termék, időszak és küszöb szűrőket,
- a vizualizációk egyértelműen mutatják a legnagyobb kockázati területeket,
- és a lap gyorsan értelmezhető a döntéshozók számára.
