FROM golang:1.7-alpine

RUN apk update && apk upgrade && apk add --virtual builddeps \
  make \
  git

# build
RUN git clone --depth 1 --recursive https://github.com/codestand/build /go/src/build
WORKDIR /go/src/build
RUN make init
RUN make build

# cleanup
RUN apk del builddeps

RUN apk update && apk upgrade && apk add --virtual rundeps \
  supervisor
RUN adduser -S web && addgroup -S web && addgroup web web
RUN mkdir /var/run/supervisor && mkdir /var/log/supervisor

COPY root /
EXPOSE 8080
ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisor/supervisord.conf"]
