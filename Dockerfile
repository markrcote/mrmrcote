FROM ghcr.io/gohugoio/hugo:v0.167.0

WORKDIR /app
COPY --chown=hugo:hugo . /app
RUN hugo --noBuildLock -d public
