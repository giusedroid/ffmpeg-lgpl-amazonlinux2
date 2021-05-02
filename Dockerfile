# ffmpeg - http://ffmpeg.org/download.html
#
# From https://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu
#

FROM        amazonlinux:2 AS base
MAINTAINER  Giuseppe Battista <giusedroid@gmail.com>
WORKDIR     /tmp/workdir

RUN     yum install -y \
        autoconf \
        automake \
        bzip2 \
        bzip2-devel \
        cmake \
        freetype-devel \
        gcc \
        gcc-c++ \
        git \
        libtool \
        make \
        pkgconfig \
        glibc-static \
        zlib-devel

FROM base as build

ENV         FFMPEG_VERSION=4.2.2

ARG         PREFIX=/opt/ffmpeg

RUN \
        DIR=/tmp/nasm && mkdir -p ${DIR} && cd ${DIR} && \
        curl -O -L https://www.nasm.us/pub/nasm/releasebuilds/2.15.05/nasm-2.15.05.tar.bz2 && \
        tar xjvf nasm-2.15.05.tar.bz2 && \
        cd nasm-2.15.05 && \
        ./autogen.sh && \
        ./configure --prefix="$PREFIX" --bindir="$PREFIX/bin" && \
        make && \
        make install

RUN \
        DIR=/tmp/nasm && mkdir -p ${DIR} && cd ${DIR} && \
        curl -O -L https://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz && \
        tar xzvf yasm-1.3.0.tar.gz && \
        cd yasm-1.3.0 && \
        ./configure --prefix="$PREFIX" --bindir="$PREFIX/bin" && \
        make && \
        make install

## ffmpeg https://ffmpeg.org/

RUN  \
        DIR=/tmp/ffmpeg && mkdir -p ${DIR} && cd ${DIR} && \
        curl -sL https://github.com/giusedroid/ffmpeg-lgpl-amazonlinux2/blob/main/ffmpeg/ffmpeg-${FFMPEG_VERSION}.tar.bz2?raw=true > ffmpeg.tar.bz2 && \
        tar -jx --strip-components=1 -f ffmpeg.tar.bz2

ENV     PATH="$PREFIX/bin:$PATH"

RUN \
        DIR=/tmp/ffmpeg && mkdir -p ${DIR} && cd ${DIR} && \
        ./configure \
        --prefix="${PREFIX}" \
        --pkg-config-flags="--static" \
        --extra-cflags="-I${PREFIX}/include -static" \
        --extra-ldflags="-L${PREFIX}/lib -static" \
        --disable-debug \
        --disable-doc \
        --disable-ffplay \
        --bindir="${PREFIX}/bin" && \
        make && \
        make install

RUN amazon-linux-extras install python3

RUN pip3 install -U pip && python3 -m pip install awscli boto3

WORKDIR /tmp/workdir

ENTRYPOINT  ["ffmpeg"]
