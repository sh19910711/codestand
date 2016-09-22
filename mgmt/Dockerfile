FROM ruby:2.3.1-alpine

RUN apk update && apk upgrade && apk add --virtual builddeps \
  build-base \
  git

RUN adduser -S webapp && \
  addgroup -S webapp && \
  addgroup webapp webapp

RUN mkdir -p /app && chown webapp. /app

# rundeps
RUN apk update && apk upgrade && apk add --virtual rundeps \
  postgresql-dev \
  supervisor \
  nodejs \
  tzdata

RUN mkdir /var/run/supervisor && mkdir /var/log/supervisor

# prepare webapp
USER webapp
RUN git clone --depth 1 --recursive https://github.com/codestand/mgmt /app
WORKDIR /app
RUN gem install bundler
RUN bundle install -j4 --without development test mysql
# TODO: update config/database.yml
RUN echo 'production:' > config/database.yml && \
    echo '  url: <%= ENV["DATABASE_URL"] %>' >> config/database.yml
RUN echo 'production:' > config/secrets.yml && \
    echo "  secret_key_base: \"$(cat /dev/urandom | strings | tr -dc 'a-zA-Z0-9' | head -c 128)\"" >> config/secrets.yml
RUN cat config/secrets.yml

USER root
RUN apk del builddeps
RUN chmod go-w /usr/local/bundle
COPY root /
EXPOSE 8080
ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisor/supervisord.conf"]
