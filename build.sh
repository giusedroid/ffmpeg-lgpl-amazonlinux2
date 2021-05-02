#!/bin/bash

FFMPEG_VERSION=4.2.2
PREFIX="/opt"

echo "Installing build tools"

sudo yum install -y \
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
    
mkdir ffmpeg_sources
cd ffmpeg_sources/

echo "Installing NASM"

curl -O -L https://www.nasm.us/pub/nasm/releasebuilds/2.15.05/nasm-2.15.05.tar.bz2
tar xjvf nasm-2.15.05.tar.bz2
cd nasm-2.15.05
./autogen.sh
./configure --prefix="$PREFIX/ffmpeg_build" --bindir="$PREFIX/bin"
make
make install

cd ..

echo "Installing YASM"

curl -O -L https://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz
tar xzvf yasm-1.3.0.tar.gz
cd yasm-1.3.0
./configure --prefix="$PREFIX/ffmpeg_build" --bindir="$PREFIX/bin"
make
make install

cd ..


echo "Compiling FFMPEG"

mkdir ffmpeg_src/
cd ffmpeg_src/
curl -sL https://github.com/giusedroid/ffmpeg-lgpl-amazonlinux2/blob/master/ffmpeg/ffmpeg-${FFMPEG_VERSION}.tar.bz2?raw=true > ffmpeg.tar.bz2 && \
        tar -jx --strip-components=1 -f ffmpeg.tar.bz2
        
PATH="$PREFIX/bin:$PATH"
PKG_CONFIG_PATH="$PREFIX/ffmpeg_build/lib/pkgconfig"

./configure \
    --prefix="$PREFIX/ffmpeg_build" \
    --pkg-config-flags="--static" \
    --extra-cflags="-I$PREFIX/ffmpeg_build/include -static" \
    --extra-ldflags="-L$PREFIX/ffmpeg_build/lib -static" \
    --disable-debug \
    --disable-doc \
    --disable-ffplay \
    --bindir="$PREFIX/bin"

make
make install

cd ..
