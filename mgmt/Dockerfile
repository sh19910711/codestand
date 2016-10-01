FROM ruby:2.3.1-alpine

# middleware
RUN apk update && apk upgrade && \
  apk add --virtual builddeps git gcc g++ make && \
  apk add postgresql-dev supervisor nodejs tzdata sqlite-dev && \
  mkdir /var/run/supervisor && mkdir /var/log/supervisor

# webapp
RUN addgroup -S web && adduser -G web -S web && \
  git clone --depth 1 --recursive https://github.com/codestand/mgmt /app && \
  chown -R web. /app

USER web
RUN cd /app && \
  gem install bundler && \
  bundle install -j2 --without mysql && \
  echo 'production:' > config/database.yml && \
  echo '  url: <%= ENV["DATABASE_URL"] %>' >> config/database.yml

USER root
RUN apk del --purge builddeps && chmod -R go-w /usr/local/bundle

COPY root /
EXPOSE 8080
ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisor/supervisord.conf"]
