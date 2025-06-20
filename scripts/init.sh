#!/bin/bash
set -euo pipefail

SERVICES=(Iris Shuffle misp suricata-zeek wazuh-docker-main)

# Étape 1 : Créer les .env des services s'ils n'existent pas
for svc in "${SERVICES[@]}"; do
  example="$svc/.env.example"
  target="$svc/.env"
  if [ -f "$example" ] && [ ! -f "$target" ]; then
    cp "$example" "$target"
    echo "Created $target"
  fi
done

# Étape 2 : Concaténer tous les .env → .env global à la racine
FINAL_ENV=".env"
TMP_ENV=".env.tmp"
BACKUP_ENV=".env.backup.$(date +%s)"

# Sauvegarde de l'ancien .env s'il existe
[ -f "$FINAL_ENV" ] && cp "$FINAL_ENV" "$BACKUP_ENV" && echo "Ancien .env sauvegardé dans $BACKUP_ENV"

# Liste des fichiers à fusionner
files=()
for svc in "${SERVICES[@]}"; do
  [ -f "$svc/.env" ] && files+=("$svc/.env")
done

# Vérification
if [ ${#files[@]} -eq 0 ]; then
  echo "Erreur : aucun fichier .env trouvé à fusionner."
  exit 1
fi

# Fusion avec en-têtes
: > "$TMP_ENV"
for file in "${files[@]}"; do
  {
    echo "# ===== $file ====="
    cat "$file"
    echo
  } >> "$TMP_ENV"
done

# Dé-duplication : garde la dernière valeur pour chaque clé
awk -F= '
  /^[[:space:]]*#/       {print; next}
  NF>=2 { kv[$1]=$0; next }
  { print }
  END { for (k in kv) print kv[k] }
' "$TMP_ENV" > "$FINAL_ENV" && rm "$TMP_ENV"

echo "Fichier .env généré avec succès à partir de :"
printf '  - %s\n' "${files[@]}"
