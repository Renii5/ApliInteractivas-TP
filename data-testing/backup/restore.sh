#!/usr/bin/env bash
# ============================================================
# Restaura el backup de data-testing/backup/ en la base local:
#   - Reemplaza TODO el contenido de ecommerce_db3 por el del dump
#
# Las imágenes que referencia el dump ya están en images/ (raíz del back, versionada).
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

# Ruta del backup para docker cp (en Git Bash hay que pasarla en formato Windows)
HOST_DIR="$DIR"
if command -v cygpath >/dev/null 2>&1; then HOST_DIR="$(cygpath -w "$DIR")"; fi

docker cp "$HOST_DIR/$DB.sql" "$CONTAINER:/tmp/restore.sql"
docker exec "$CONTAINER" sh -c "mysql -uroot --default-character-set=utf8mb4 < /tmp/restore.sql"
docker exec "$CONTAINER" rm /tmp/restore.sql

echo "Base $DB restaurada"
