FROM ubuntu:16.04

ENV BUILD_SERVER_VERSION=0.0.2

RUN apt-get update && apt-get install -y curl tar supervisor && \
  mkdir /var/run/supervisor
RUN mkdir -p /app && curl -L https://github.com/codestand/build/releases/download/$BUILD_SERVER_VERSION/app.tar.gz | tar -C /app -zxvf -
RUN useradd web && chown web. /app

COPY root /
EXPOSE 8080
ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisor/supervisord.conf"]
