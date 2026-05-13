# ---------- Builder stage ----------
FROM python:3.10-bookworm AS builder

ENV PUID=99 \
    PGID=100 \
    UMASK=002 \
    TZ=America/New_York

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git curl unzip imagemagick \
        libjpeg62-turbo libpng16-16 libtiff6 libfreetype6 \
        liblcms2-2 libwebp7 libharfbuzz0b libfribidi0 \
        libxcb1 libx11-6 libxext6 libxrender1 libxft2 \
        libxml2 libxslt1.1 ca-certificates && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN git clone https://github.com/janeczku/calibre-web.git /app/calibre-web

WORKDIR /app/calibre-web

RUN pip install --no-cache-dir -r requirements.txt

COPY scripts/plugin-setup.sh /app/plugin-setup.sh
RUN chmod +x /app/plugin-setup.sh && /app/plugin-setup.sh /app/calibre-web


# ---------- Runtime stage ----------
FROM python:3.10-bookworm AS runtime

ENV PUID=99 \
    PGID=100 \
    UMASK=002 \
    TZ=America/New_York

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        imagemagick \
        libjpeg62-turbo libpng16-16 libtiff6 libfreetype6 \
        liblcms2-2 libwebp7 libharfbuzz0b libfribidi0 \
        libxcb1 libx11-6 libxext6 libxrender1 libxft2 \
        libxml2 libxslt1.1 ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -u ${PUID} -m abc

WORKDIR /app/calibre-web

COPY --from=builder /usr/local/lib /usr/local/lib
COPY --from=builder /usr/lib /usr/lib
COPY --from=builder /usr/local/bin /usr/local/bin

COPY --from=builder /app/calibre-web /app/calibre-web

COPY scripts/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh && chown -R abc:abc /app

USER abc

EXPOSE 8083

ENTRYPOINT ["/entrypoint.sh"]
