FROM ruby:2.3.1

RUN apt-get update && apt-get install -y git build-essential libxml2-dev supervisor nodejs tzdata sqlite3
RUN mkdir -p /var/run/supervisor

RUN useradd -ms /bin/false web
RUN git clone --depth 1 --recursive https://github.com/codestand/mgmt /app
WORKDIR /app
RUN bundle install -j2 --without test --without development --without mysql
RUN bundle exec rails db:migrate

USER root
COPY root /
EXPOSE 8080
CMD ["supervisord", "--nodaemon", "--configuration", "/etc/supervisor/supervisord.conf"]
