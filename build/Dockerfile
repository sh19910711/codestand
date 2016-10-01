FROM alpine:3.4

ENV BUILD_SERVER_VERSION=0.0.2

RUN apk update && apk upgrade && apk add --no-cache curl tar supervisor
RUN mkdir -p /app && curl -L https://github.com/codestand/build/releases/download/$BUILD_SERVER_VERSION/app.tar.gz | tar -C /app -zxvf -
RUN mkdir /var/run/supervisor && mkdir /var/log/supervisor
RUN addgroup -S web && adduser -G web -S web

COPY root /
EXPOSE 8080
ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisor/supervisord.conf"]
