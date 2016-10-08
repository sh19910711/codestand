FROM ruby:2.3.1

ENV MGMT_SERVER_VERSION=f12102d51307fd9b23760b780040e50c66037f36

RUN sed -i -e 's#http://archive.ubuntu.com/ubuntu/#mirror://mirrors.ubuntu.com/mirrors.txt#' /etc/apt/sources.list
RUN apt-get update && apt-get install -y git build-essential libxml2-dev supervisor nodejs tzdata sqlite3
RUN mkdir -p /var/run/supervisor

RUN git clone https://github.com/codestand/mgmt /app
RUN cd /app && git reset --hard $MGMT_SERVER_VERSION
RUN useradd -m web && chown -R web. /app
USER web
WORKDIR /app
ENV RAILS_ENV=production
ENV SECRET_KEY_BASE=not-a-secret
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install -j3 --without test mysql
RUN bundle exec rails db:migrate

USER root
COPY root /
EXPOSE 8080
CMD ["supervisord", "--nodaemon", "--configuration", "/etc/supervisor/supervisord.conf"]
