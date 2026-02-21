FROM ghcr.io/gohugoio/hugo:v0.156.0

WORKDIR /app
COPY --chown=hugo:hugo . /app
RUN hugo --noBuildLock -d public
