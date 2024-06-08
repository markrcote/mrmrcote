FROM peaceiris/hugo:v0.127.0

WORKDIR /app
COPY . /app
RUN hugo -d public
