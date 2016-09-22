FROM ruby:2.3.1-alpine

RUN apk update && apk upgrade && apk add --virtual builddeps \
  build-base \
  git

RUN adduser -S web && \
  addgroup -S web && \
  addgroup web web

RUN mkdir -p /app && chown web. /app

# rundeps
RUN apk update && apk upgrade && apk add --virtual rundeps \
  postgresql-dev \
  supervisor \
  nodejs

RUN mkdir /var/run/supervisor && mkdir /var/log/supervisor

USER web
RUN git clone --depth 1 --recursive https://github.com/codestand/mockup /app
WORKDIR /app
RUN gem install bundler
RUN bundle install -j4 --without development test

USER root
RUN apk del builddeps
RUN chmod go-w /usr/local/bundle
COPY root /
EXPOSE 8080
ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisor/supervisord.conf"]
