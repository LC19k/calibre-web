---
# Changelog

All notable changes to this image will be documented in this file.

This image tracks upstream [`janeczku/calibre-web`](https://github.com/janeczku/calibre-web) and adds:

- Automated stable/nightly builds
- Multi-stage Dockerfile
- Plugin auto-patching
- GHCR label-based state tracking

## [Unreleased]

- Internal improvements to CI/CD
- Documentation updates

## [2026-05-10] Initial automated pipeline

- Added upstream-aware GitHub Actions workflow:
  - Stable builds on new upstream releases
  - Nightly builds on new upstream commits
- Added multi-stage Dockerfile (builder + runtime)
- Added plugin auto-patcher (`scripts/plugin-setup.sh`)
- Published images to `ghcr.io/lc19k/calibre-web`:
  - `stable`, `stable-YYYYMMDD-HHMM`, `latest`
  - `nightly`, `nightly-YYYYMMDD-HHMM`
