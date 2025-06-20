#!/bin/bash

FINAL_ENV=".env"
TMP_ENV=".env.tmp"

# Liste des fichiers à agréger
files=()
[ -f "$FINAL_ENV" ] && files+=("$FINAL_ENV")
for svc in "${SERVICES[@]}"; do
  [ -f "$svc/.env" ] && files+=("$svc/.env")
done

# Concaténation avec entêtes
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

echo "Rebuilt merged .env"
