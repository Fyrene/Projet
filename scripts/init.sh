#!/bin/bash

for svc in "${SERVICES[@]}"; do
  example="$svc/.env.example"
  target="$svc/.env"
  if [ -f "$example" ] && [ ! -f "$target" ]; then
    cp "$example" "$target"
    echo "Created $target"
  fi
done

FINAL_ENV=".env"
TMP_ENV=".env.tmp"
BACKUP_ENV=".env.backup.$(date +%s)"

[ -f "$FINAL_ENV" ] && cp "$FINAL_ENV" "$BACKUP_ENV" && echo "Ancien .env sauvegardé dans $BACKUP_ENV"

files=()
[ -s "$FINAL_ENV" ] && files+=("$FINAL_ENV")
for svc in "${SERVICES[@]}"; do
  [ -f "$svc/.env" ] && files+=("$svc/.env")
done

if [ ${#files[@]} -eq 0 ]; then
  echo "Erreur : aucun fichier .env trouvé à fusionner."
  exit 1
fi

: > "$TMP_ENV"
for file in "${files[@]}"; do
  {
    echo "# ===== $file ====="
    cat "$file"
    echo
  } >> "$TMP_ENV"
done

awk -F= '
  /^[[:space:]]*#/       {print; next}
  NF>=2 { kv[$1]=$0; next }
  { print }
  END { for (k in kv) print kv[k] }
' "$TMP_ENV" > "$FINAL_ENV" && rm "$TMP_ENV"

echo "Fichier .env généré avec succès à partir de :"
printf '  - %s\n' "${files[@]}"
