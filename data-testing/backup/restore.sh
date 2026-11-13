#!/usr/bin/env bash
# ============================================================
# Restaura el backup de data-testing/backup/ en la base local:
#   - Reemplaza TODO el contenido de ecommerce_db3 por el del dump
#   - Copia las imágenes del backup a uploads/ (si data-testing/backup/uploads/ existe)
#
# Requiere el contenedor "mysql-open" corriendo. Conviene tener el back apagado.
# Uso (desde la raíz del back, en Git Bash / macOS / Linux):
#   bash data-testing/backup/restore.sh
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

docker cp "$HOST_DIR/$DB.sql" "$CONTAINER:/tmp/restore.sql"
docker exec "$CONTAINER" sh -c "mysql -uroot --default-character-set=utf8mb4 < /tmp/restore.sql"
docker exec "$CONTAINER" rm /tmp/restore.sql

echo "Base $DB restaurada"

# Las imágenes subidas son opcionales: data-testing/backup/uploads/ puede no estar en el repo
if [ -d "$DIR/uploads" ]; then
  mkdir -p "$ROOT/uploads"
  find "$DIR/uploads" -type f ! -name .gitkeep -exec cp {} "$ROOT/uploads/" \;
  echo "Imágenes copiadas a uploads/"
else
  echo "No hay imágenes en data-testing/backup/uploads/: se omite la copia"
fi
