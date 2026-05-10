# calibre-web (LC19k homelab build)

- Multi-stage Docker build
- Based on `python:3.11-bookworm`
- Plugin-enabled (Kobo Sync, Goodreads, thumbnails, etc.)
- Dual-channel:
  - `stable` – manually triggered, production
  - `nightly` – scheduled, tracks upstream

## Tags

- `stable`, `stable-YYYYMMDD-HHMM`
- `nightly`, `nightly-YYYYMMDD-HHMM`
- `latest` (alias of `stable`)

## Usage (Unraid / Dockhand)

```yaml
image: ghcr.io/lc19k/calibre-web:stable
```
