FROM ubuntu:16.04
MAINTAINER Seiya Nuta <nuta@seiya.me>

ENV GOPATH=/go
ENV DEBIAN_FRONTEND="noninteractive"

# I live in Tsukuba
RUN sed -ie 's#archive.ubuntu.com#ftp.tsukuba.wide.ad.jp/Linux#' /etc/apt/sources.list

RUN apt-get update

# emu-server
RUN apt-get install -y git golang

# qemu
RUN apt-get install -y libfdt-dev build-essential \
    zlib1g-dev libglib2.0-dev libnss3-dev libncurses5-dev \
    libpcre16-3 libpcre3-dev libpixman-1-0 libpixman-1-dev

RUN git clone https://github.com/codestand/emu-server /go/src/github.com/codestand/emu-server
WORKDIR /go/src/github.com/codestand/emu-server

RUN PATH=$GOPATH/bin:$PATH make get-deps
RUN make build-qemu
RUN make build

CMD ["./codestand-emu-server"]
