FROM alpine:3.4

RUN apk update && apk upgrade && \
  apk add --virtual builddeps gcc g++ make curl ruby-dev ruby-rake bison perl git && \
  apk add pcre-dev zlib-dev

ENV NGINX_VERSION="1.10.1"

# build nginx
WORKDIR /usr/src
RUN curl -SL https://nginx.org/download/nginx-$NGINX_VERSION.tar.gz | tar zxvf -
WORKDIR /usr/src/
RUN cd nginx-$NGINX_VERSION && \
  ./configure --prefix=/usr/local && \
  make && \
  make install && \
  apk del --purge builddeps && \
  rm -rf /usr/src && \
  addgroup -S nginx && adduser -G nginx -S nginx && \
  mkdir -p /var/log/nginx && chown nginx. /var/log/nginx

# copy configurations
COPY root /

EXPOSE 80
CMD ["/usr/local/sbin/nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]
