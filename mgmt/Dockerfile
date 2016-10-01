FROM ruby:2.3.1

RUN apt-get update && apt-get install -y git build-essential libxml2-dev supervisor nodejs tzdata sqlite3
RUN mkdir -p /var/run/supervisor

RUN git clone --depth 1 https://github.com/codestand/mgmt /app
RUN useradd -m web && chown -R web. /app
USER web
WORKDIR /app
ENV RAILS_ENV=production
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install -j3 --without test mysql
RUN bundle exec rails db:migrate

USER root
COPY root /
EXPOSE 8080
CMD ["supervisord", "--nodaemon", "--configuration", "/etc/supervisor/supervisord.conf"]
