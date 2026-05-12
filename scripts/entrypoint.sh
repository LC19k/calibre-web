#!/bin/bash
set -e

echo "Running upstream Calibre-Web with data directory at /config and app at /app/calibre-web"

# Ensure /config exists and is writable
mkdir -p /config
chown -R abc:abc /config

# Helper: move file if exists and not already in /config
move_if_present() {
  local src="$1"
  local dst="$2"

  if [ -f "$src" ] && [ ! -f "$dst" ]; then
    echo "Moving $src -> $dst"
    mv "$src" "$dst"
  fi
}

# Helper: move dir if exists and not already in /config
move_dir_if_present() {
  local src="$1"
  local dst="$2"

  if [ -d "$src" ] && [ ! -d "$dst" ]; then
    echo "Moving $src -> $dst"
    mv "$src" "$dst"
  fi
}

# Files we want persistent in /config
move_if_present /app/calibre-web/app.db          /config/app.db
move_if_present /app/calibre-web/gdrive.db       /config/gdrive.db
move_if_present /app/calibre-web/calibre-web.log /config/calibre-web.log
move_if_present /app/calibre-web/config.ini      /config/config.ini

# Dirs we want persistent in /config
move_dir_if_present /app/calibre-web/cache      /config/cache
move_dir_if_present /app/calibre-web/thumbnails /config/thumbnails

# Ensure targets exist
touch /config/app.db /config/calibre-web.log /config/config.ini
mkdir -p /config/cache /config/thumbnails

# Symlink back into app dir so upstream paths still work
ln -sf /config/app.db          /app/calibre-web/app.db
ln -sf /config/gdrive.db       /app/calibre-web/gdrive.db
ln -sf /config/calibre-web.log /app/calibre-web/calibre-web.log
ln -sf /config/config.ini      /app/calibre-web/config.ini
ln -snf /config/cache          /app/calibre-web/cache
ln -snf /config/thumbnails     /app/calibre-web/thumbnails

echo "Starting Calibre-Web from /app/calibre-web with DB at /config/app.db"

exec python3 cps.py
