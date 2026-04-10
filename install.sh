#!/usr/bin/env bash
set -euo pipefail

PROJECT_NAME="EBrigade OS V2"
PREFIX="/usr/local"
BIN_DIR="$PREFIX/bin"
SHARE_DIR="$PREFIX/share/ebrigade"
MAN_DIR="/usr/local/share/man/man1"

echo "[EBRIGADE] Installation de ${PROJECT_NAME}"

# 1. Création des dossiers
sudo mkdir -p "$BIN_DIR" "$SHARE_DIR/modules" "$SHARE_DIR/assets" "$MAN_DIR"

# 2. Installation du TUI principal (à adapter)
if [ -f "scripts/ebrigade.sh" ]; then
  sudo install -m 0755 scripts/ebrigade.sh "$BIN_DIR/ebrigade"
fi

# 3. Installation des modules
if [ -d "modules" ]; then
  sudo cp -r modules/* "$SHARE_DIR/modules/" || true
fi

# 4. Installation des assets
if [ -d "assets" ]; then
  sudo cp -r assets/* "$SHARE_DIR/assets/" || true
fi

# 5. Installation de la manpage
if [ -f "docs/man/ebrigade.1" ]; then
  sudo install -m 0644 docs/man/ebrigade.1 "$MAN_DIR/ebrigade.1"
  sudo mandb >/dev/null 2>&1 || true
fi

echo "[EBRIGADE] Installation terminée."
echo "Commande disponible : ebrigade"
