#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"
set -a
source "$SCRIPT_DIR/../.env"
set +a
export DBT_PROFILES_DIR="./conf"
if [ "$#" -eq 0 ]; then
  dbt run --target prod --profiles-dir ./conf --project-dir .
else
  dbt "$@"
fi
