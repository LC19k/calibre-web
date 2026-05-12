#!/bin/bash
set -e

# Ensure config directory exists
mkdir -p /config
chown -R abc:abc /config

# Default settings path if not provided
SETTINGS_PATH=${SETTINGS_PATH:-/config/app.db}

# Default calibre library path
CALIBRE_LIBRARY=${CALIBRE_LIBRARY:-/books}

echo "Using settings path: $SETTINGS_PATH"
echo "Using calibre library: $CALIBRE_LIBRARY"

exec python3 cps.py \
    --settings_path="$SETTINGS_PATH" \
    --calibre-library="$CALIBRE_LIBRARY"
