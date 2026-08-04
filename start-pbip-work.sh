#!/usr/bin/env bash
set -Eeuo pipefail

BRANCH="09-pbip-implementation"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

cd "$SCRIPT_DIR"

echo "========================================"
echo " Power BI PBIP napi fejlesztes inditasa"
echo " Branch: $BRANCH"
echo " Repo:   $SCRIPT_DIR"
echo "========================================"

# 1. Ellenorizzuk, hogy Git repositoryban vagyunk-e.
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "HIBA: Ez a fajl nem egy Git repository gyokermappajaban van."
    echo "Helyezd a start-pbip-work.sh fajlt a repo gyokerbe."
    exit 1
fi

# 2. Nem valtunk branchet mentetlen munka mellett.
if [[ -n "$(git status --porcelain)" ]]; then
    echo "HIBA: Mentetlen vagy nem commitolt valtozasok vannak:"
    git status --short
    echo
    echo "Elobb commitold/pushold vagy stash-eld a valtozasokat."
    exit 1
fi

# 3. Tavoli allapot frissitese.
echo
echo "[1/5] Tavoli branchek frissitese..."
git fetch --prune origin

# 4. Helyi branch letrehozasa a tavoli branchbol, ha szukseges.
echo "[2/5] Atvaltas erre: $BRANCH"
if git show-ref --verify --quiet "refs/heads/$BRANCH"; then
    git switch "$BRANCH"
elif git show-ref --verify --quiet "refs/remotes/origin/$BRANCH"; then
    git switch --track -c "$BRANCH" "origin/$BRANCH"
else
    echo "HIBA: A(z) $BRANCH branch sem helyben, sem az origin tavoli repoban nem talalhato."
    exit 1
fi

# 5. Csak konfliktusmentes, fast-forward frissitest engedunk.
echo "[3/5] Legfrissebb valtozasok letoltese..."
git pull --ff-only origin "$BRANCH"

echo "[4/5] Allapotellenorzes..."
git status --short --branch

echo "[5/5] VS Code megnyitasa..."
if command -v code >/dev/null 2>&1; then
    code .
else
    echo "FIGYELEM: A 'code' terminalparancs nem erheto el."
    echo "A repo frissitese sikerult; nyisd meg kezzel a mappat a VS Code-ban."
fi

echo
echo "KESZ: A napi munkat a(z) $BRANCH branchen kezdheted."
echo "Nap vegen hasznald a save-work.sh fajlt."
