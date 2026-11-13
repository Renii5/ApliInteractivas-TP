#!/usr/bin/env bash
# ============================================================
# Genera el backup de la base local en data-testing/backup/:
#   - ecommerce_db3.sql : dump completo (estructura + datos)
#   - uploads/          : copia de las imágenes subidas (uploads/ no se versiona)
#
# Requiere el contenedor "mysql-open" corriendo.
# Uso (desde la raíz del back, en Git Bash / macOS / Linux):
#   bash data-testing/backup/backup.sh
# ============================================================
set -euo pipefail

# Evita que Git Bash convierta /tmp en una ruta de Windows
export MSYS_NO_PATHCONV=1

CONTAINER="mysql-open"
DB="ecommerce_db3"
DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$DIR/../.." && pwd)"

# Ruta del backup para docker cp (en Git Bash hay que pasarla en formato Windows)
HOST_DIR="$DIR"
if command -v cygpath >/dev/null 2>&1; then HOST_DIR="$(cygpath -w "$DIR")"; fi

# El dump se genera dentro del contenedor para no depender del encoding de la terminal.
# --skip-extended-insert: una fila por línea, así los cambios se ven claros en el diff de git.
# --skip-dump-date: sin fecha al final, así no hay diff si los datos no cambiaron.
docker exec "$CONTAINER" mysqldump -uroot --databases "$DB" \
  --no-tablespaces --default-character-set=utf8mb4 \
  --skip-extended-insert --skip-dump-date \
  --result-file=/tmp/backup.sql
docker cp "$CONTAINER:/tmp/backup.sql" "$HOST_DIR/$DB.sql"
docker exec "$CONTAINER" rm /tmp/backup.sql

# Imágenes subidas: se reemplaza la copia entera para que refleje uploads/ tal como está
rm -rf "$DIR/uploads"
mkdir -p "$DIR/uploads"
if [ -d "$ROOT/uploads" ]; then
  cp -r "$ROOT/uploads/." "$DIR/uploads/"
fi
touch "$DIR/uploads/.gitkeep"

echo "Backup generado en data-testing/backup/ ($DB.sql + uploads/)"
