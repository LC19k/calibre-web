#!/bin/bash
set -e

echo "Running upstream Calibre-Web with internal DB directory at /app/calibre-web"

exec python3 cps.py
