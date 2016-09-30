FROM alpine:3.4

RUN apk update && apk upgrade && apk add --no-cache curl tar supervisor && \
  mkdir -p /app && curl -L https://github.com/codestand/build/releases/download/0.0.2/app.tar.gz | tar -o -C /app -zxvf - && \
  mkdir /var/run/supervisor && mkdir /var/log/supervisor && \
  adduser -S web && addgroup -S web && addgroup web web

COPY root /
EXPOSE 8080
ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisor/supervisord.conf"]
