#!/bin/bash

FINAL_ENV=".env"
TMP_ENV=".env.fusion.tmp"
BACKUP_ENV=".env.backup.$(date +%s)"

# Sauvegarde de l'ancien .env s'il existe
if [ -f "$FINAL_ENV" ]; then
  cp "$FINAL_ENV" "$BACKUP_ENV"
  echo "Ancien .env sauvegardé dans $BACKUP_ENV"
fi

# Liste des fichiers à concaténer
files=()
[ -f "$FINAL_ENV" ] && files+=("$FINAL_ENV")
for svc in "${SERVICES[@]}"; do
  [ -f "$svc/.env" ] && files+=("$svc/.env")
done

# Si aucun fichier trouvé, stop
if [ ${#files[@]} -eq 0 ]; then
  echo "Erreur : aucun fichier .env trouvé à fusionner."
  exit 1
fi

# Fusion
: > "$TMP_ENV"
for file in "${files[@]}"; do
  {
    echo "# ===== $file ====="
    cat "$file"
    echo
  } >> "$TMP_ENV"
done

# Dé-duplication des variables (garde la dernière occurrence)
awk -F= '
  /^[[:space:]]*#/       {print; next}
  NF>=2 { kv[$1]=$0; next }
  { print }
  END { for (k in kv) print kv[k] }
' "$TMP_ENV" > "$FINAL_ENV" && rm "$TMP_ENV"

echo "Fichier .env généré avec succès à partir de :"
printf '  - %s\n' "${files[@]}"
