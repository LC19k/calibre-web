FROM python:3.11-slim

ENV PUID=99 \
    PGID=100 \
    UMASK=002 \
    TZ=America/New_York

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
        && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd -g ${PGID} abc && \
    useradd -u ${PUID} -g ${PGID} -m abc

RUN git clone https://github.com/janeczku/calibre-web.git /app/calibre-web

WORKDIR /app/calibre-web

RUN pip install --no-cache-dir -r requirements.txt

RUN chown -R abc:abc /app

USER abc

EXPOSE 8083

CMD ["python3", "cps.py"]
