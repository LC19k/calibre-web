#!/bin/bash
set -e

# Ensure config directory exists
mkdir -p /config
chown -R abc:abc /config

# Upstream Calibre-Web environment variables
export CALIBRE_WEB_DB=${CALIBRE_WEB_DB:-/config/app.db}
export CALIBRE_LIBRARY=${CALIBRE_LIBRARY:-/books}

echo "Using CALIBRE_WEB_DB: $CALIBRE_WEB_DB"
echo "Using CALIBRE_LIBRARY: $CALIBRE_LIBRARY"

exec python3 cps.py
