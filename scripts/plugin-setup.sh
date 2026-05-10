#!/usr/bin/env bash
set -euo pipefail

CALIBRE_WEB_DIR="${1:-/app/calibre-web}"
PLUGINS_DIR="${CALIBRE_WEB_DIR}/cps/plugins"

mkdir -p "${PLUGINS_DIR}"

echo "Installing Calibre-Web plugins into: ${PLUGINS_DIR}"

# NOTE: URLs are examples; adjust to your preferred forks if needed.

# Kobo Sync
curl -fsSL -o "${PLUGINS_DIR}/kobo-sync.zip" \
  "https://github.com/janeczku/calibre-web-kobo-sync/archive/refs/heads/master.zip" || true

# Goodreads Metadata
curl -fsSL -o "${PLUGINS_DIR}/goodreads-metadata.zip" \
  "https://github.com/janeczku/calibre-web-goodreads/archive/refs/heads/master.zip" || true

# Goodreads Sync
curl -fsSL -o "${PLUGINS_DIR}/goodreads-sync.zip" \
  "https://github.com/janeczku/calibre-web-goodreads-sync/archive/refs/heads/master.zip" || true

# Thumbnail Generator
curl -fsSL -o "${PLUGINS_DIR}/thumbnail-generator.zip" \
  "https://github.com/janeczku/calibre-web-thumbnail/archive/refs/heads/master.zip" || true

# Calibre-Web Extended (CWE)
curl -fsSL -o "${PLUGINS_DIR}/calibre-web-extended.zip" \
  "https://github.com/janeczku/calibre-web-extended/archive/refs/heads/master.zip" || true

# LDAP Auth (example)
curl -fsSL -o "${PLUGINS_DIR}/ldap-auth.zip" \
  "https://github.com/janeczku/calibre-web-ldap/archive/refs/heads/master.zip" || true

# OPDS Enhancements (example)
curl -fsSL -o "${PLUGINS_DIR}/opds-enhancements.zip" \
  "https://github.com/janeczku/calibre-web-opds/archive/refs/heads/master.zip" || true

# Custom CSS Loader (example)
curl -fsSL -o "${PLUGINS_DIR}/custom-css.zip" \
  "https://github.com/janeczku/calibre-web-custom-css/archive/refs/heads/master.zip" || true

# Series Metadata Enhancer (example)
curl -fsSL -o "${PLUGINS_DIR}/series-metadata.zip" \
  "https://github.com/janeczku/calibre-web-series/archive/refs/heads/master.zip" || true

# Author Image Fetcher (example)
curl -fsSL -o "${PLUGINS_DIR}/author-images.zip" \
  "https://github.com/janeczku/calibre-web-author-images/archive/refs/heads/master.zip" || true

# KEPUBify / helpers (optional placeholder)
# You can wire this to your own kepubify integration later.

echo "Plugin download phase complete (missing URLs are tolerated)."
