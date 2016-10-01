FROM ruby:2.3.1-alpine

# middleware
RUN apk update && apk upgrade && \
  apk add --no-cache git build-base libxml2-dev postgresql-dev supervisor nodejs tzdata sqlite-dev && \
  mkdir /var/run/supervisor && mkdir /var/log/supervisor

# webapp
RUN addgroup -S web && adduser -G web -S web && \
  git clone --depth 1 --recursive https://github.com/codestand/mgmt /app && \
  chown -R web. /app && \
  cd /app && \
  echo 'production:' > config/database.yml && \
  echo '  url: <%= ENV["DATABASE_URL"] %>' >> config/database.yml

WORKDIR /app
USER root
COPY root /
EXPOSE 8080
CMD ["supervisord", "--nodaemon", "--configuration", "/etc/supervisor/supervisord.conf"]
