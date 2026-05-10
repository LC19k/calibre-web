# ---------- Builder stage ----------
FROM python:3.11-bookworm AS builder

ENV PUID=99 \
    PGID=100 \
    UMASK=002 \
    TZ=America/New_York

# Build + runtime deps (bookworm, no version pins, stable base)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        curl \
        unzip \
        imagemagick \
        libjpeg62-turbo \
        libpng16-16 \
        libtiff6 \
        libfreetype6 \
        liblcms2-2 \
        libwebp7 \
        libharfbuzz0b \
        libfribidi0 \
        libxcb1 \
        libx11-6 \
        libxext6 \
        libxrender1 \
        libxft2 \
        libxml2 \
        libxslt1.1 \
        ca-certificates \
        && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Clone Calibre-Web (upstream)
RUN git clone https://github.com/janeczku/calibre-web.git /app/calibre-web

WORKDIR /app/calibre-web

# Install Python deps
RUN pip install --no-cache-dir -r requirements.txt

# Copy plugin setup script
COPY scripts/plugin-setup.sh /app/plugin-setup.sh
RUN chmod +x /app/plugin-setup.sh && /app/plugin-setup.sh /app/calibre-web

# ---------- Runtime stage ----------
FROM python:3.11-bookworm AS runtime

ENV PUID=99 \
    PGID=100 \
    UMASK=002 \
    TZ=America/New_York

# Only runtime libs (no build tools)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        imagemagick \
        libjpeg62-turbo \
        libpng16-16 \
        libtiff6 \
        libfreetype6 \
        liblcms2-2 \
        libwebp7 \
        libharfbuzz0b \
        libfribidi0 \
        libxcb1 \
        libx11-6 \
        libxext6 \
        libxrender1 \
        libxft2 \
        libxml2 \
        libxslt1.1 \
        ca-certificates \
        && \
    rm -rf /var/lib/apt/lists/*

# Create runtime user (no GID assumptions)
RUN useradd -u ${PUID} -m abc

WORKDIR /app/calibre-web

# Copy app from builder
COPY --from=builder /app/calibre-web /app/calibre-web

# Ensure ownership
RUN chown -R abc:abc /app

USER abc

EXPOSE 8083

CMD ["python3", "cps.py"]
