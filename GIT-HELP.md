# PowerBI-MCP Git Cheat Sheet

## Aktuális branch megtekintése

```bash
git branch --show-current
```

---

## Összes local branch

```bash
git branch
```

---

## Összes remote branch

```bash
git branch -r
```

---

## Átváltás egy branch-re

```bash
git switch main
```

vagy

```bash
git switch 09-pbip-implementation
```

---

## Main frissítése GitHubról

```bash
git switch main
git pull
```

---

## Napi fejlesztés indítása

```bash
git switch 09-pbip-implementation
git pull
```

vagy

```bash
./start-pbip-work.sh
```

---

# Mentés

## Állapot ellenőrzése

```bash
git status
```

---

## Gyors mentés

```bash
./save-work.sh "Claims KPI complete"
```

---

## Manuális mentés

```bash
git add .
git commit -m "Claims KPI complete"
git push
```

---

# GitHub szinkron

## Változások letöltése

```bash
git pull
```

---

## Változások feltöltése

```bash
git push
```

---

# Feature branchek

## Új branch létrehozása

```bash
git switch main
git pull

git switch -c 12-training-pack

git push -u origin 12-training-pack
```

---

## Branch törlése helyben

```bash
git branch -d 12-training-pack
```

---

## Branch törlése GitHubon

```bash
git push origin --delete 12-training-pack
```

---

# Merge

## Main beolvasztása feature branchbe

```bash
git switch 09-pbip-implementation
git merge main
```

---

## Merge befejezése

Ha a Git ezt írja:

```text
All conflicts fixed but you are still merging.
```

akkor:

```bash
git commit --no-edit
```

---

# Hibaelhárítás

## Nem tudok branchet váltani

Hiba:

```text
cannot switch branch while merging
```

Ellenőrzés:

```bash
git status
```

Lezárás:

```bash
git commit --no-edit
```

vagy

```bash
git merge --abort
```

---

## Nem látom a branch-et GitHubon

Push:

```bash
git push -u origin <branch-nev>
```

Példa:

```bash
git push -u origin 11-devops-automation
```

---

# Projekt branch-ek

```text
main
09-pbip-implementation
10-mcp-skills
11-devops-automation
```

## Mire való?

main
- stabil állapot

09-pbip-implementation
- Power BI PBIP fejlesztés

10-mcp-skills
- MCP skillek
- promptok
- agentek

11-devops-automation
- shell scriptek
- automatizációk
- GitHub workflow

---

# Napi rutin

Reggel:

```bash
./start-pbip-work.sh
```

Napközben:

```bash
./save-work.sh "Aktuális fejlesztés"
```

Este:

```bash
./save-work.sh "End of day"
```

Másik gépen:

```bash
git pull
```

Folytatás ugyanonnan.
