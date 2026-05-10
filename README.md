# calibre-web (LC19k build)

![Build status](https://github.com/lc19k/calibre-web/actions/workflows/build.yml/badge.svg)

A fully automated, upstream-aware, dual-channel Calibre-Web container image with:

- **Stable channel** – auto-builds when upstream publishes a new release
- **Nightly channel** – auto-builds when upstream commits change
- **Multi-stage Dockerfile** – minimal, secure runtime image
- **Plugin auto-patcher** – Kobo Sync, Goodreads, thumbnails, CWE, and more
- **GHCR label-driven state tracking** – no repo clutter
- **Dockhand-friendly tags** – `stable`, `nightly`, timestamped variants

Upstream source: [`janeczku/calibre-web`](https://github.com/janeczku/calibre-web)

---

## Features

### Stable channel (automatic)

- Tracks upstream GitHub releases
- Builds only when a new release is published
- Tags:
  - `stable`
  - `stable-YYYYMMDD-HHMM`
  - `sha-<commit>`
  - `latest` (alias of `stable`)

### Nightly channel (automatic)

- Tracks upstream default branch (`master`)
- Builds only when upstream commits change
- Tags:
  - `nightly`
  - `nightly-YYYYMMDD-HHMM`

### GHCR label tracking

Each image embeds metadata:

- `org.opencontainers.image.source_release`
- `org.opencontainers.image.source_commit`
- `org.opencontainers.image.source_channel`
- `org.opencontainers.image.version`

The workflow reads these labels to decide whether a rebuild is needed.

### Multi-stage Dockerfile

- **Builder stage**: installs build deps + plugins
- **Runtime stage**: only minimal runtime libs
- No compilers, no git, no curl, no apt in the final image.

### Plugin auto-patcher

Automatically downloads/installs (via `scripts/plugin-setup.sh`):

- Kobo Sync  
- Goodreads Metadata  
- Goodreads Sync  
- Thumbnail Generator  
- Calibre-Web Extended (CWE)  
- LDAP Auth  
- OPDS Enhancements  
- Custom CSS Loader  
- Series Metadata Enhancer  
- Author Image Fetcher  
- KEPUBify hooks (optional)

---

## Automation

### Workflow

Single workflow: `.github/workflows/build.yml`

It handles:

- Upstream release detection (for `stable`)
- Upstream commit detection (for `nightly`)
- GHCR login
- Multi-stage build
- Label injection
- GHCR publishing

Triggers:

- Nightly at `05:00` UTC (`schedule`)
- On push to `main`
- Manual run (`workflow_dispatch`)

---

## Tags

| Channel   | Description              | Tags                                |
|-----------|--------------------------|-------------------------------------|
| Stable    | Tracks upstream releases | `stable`, `stable-YYYYMMDD-HHMM`, `latest` |
| Nightly   | Tracks upstream commits  | `nightly`, `nightly-YYYYMMDD-HHMM`  |

---

## Pulling the image

### Stable (recommended)

```bash
docker pull ghcr.io/lc19k/calibre-web:stable
```
### Nightly (testing)
```
docker pull ghcr.io/lc19k/calibre-web:nightly
```
## Docker Compose (Unraid / Dockhand)
### Stable
```
calibre-web:
  image: ghcr.io/lc19k/calibre-web:stable
  container_name: calibre-web
  network_mode: host
  environment:
    - PUID=${PUID}
    - PGID=${PGID}
    - TZ=${TZ}
    - UMASK=${UMASK}
  volumes:
    - ${BOOKS_CONFIG}/calibre-web:/config
    - ${BOOKS_LIBRARY}:/books
  restart: unless-stopped
```
### Nightly (optional)
```
calibre-web-nightly:
  image: ghcr.io/lc19k/calibre-web:nightly
  container_name: calibre-web-nightly
  network_mode: host
  environment:
    - PUID=${PUID}
    - PGID=${PGID}
    - TZ=${TZ}
    - UMASK=${UMASK}
  volumes:
    - ${BOOKS_CONFIG}/calibre-web-nightly:/config
    - ${BOOKS_LIBRARY}:/books
  restart: unless-stopped
```
---
## Repository structure
```
/
├── Dockerfile
├── scripts/
│   └── plugin-setup.sh
└── .github/
    └── workflows/
        └── build.yml
```
## License
### This repository builds Calibre-Web from the upstream project.
### All Calibre-Web licensing terms apply to the built software.
---
