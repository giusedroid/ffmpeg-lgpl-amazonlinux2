# ffmpeg-lgpl-amazonlinux2
<!--![build status](https://travis-ci.com/giusedroid/ffmpeg-lgpl-ubuntu.svg?branch=master)--> 
FFmpeg Docker container compiled to be compatible with LGPL starting from AmazonLinux2.  
FFmpeg has been compiled as a single static binary to use it with AWS Lambda Layers.

## Legal Notice about the usage of FFmpeg

This software uses code of <a href=http://ffmpeg.org>FFmpeg</a> licensed under
the <a href=http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html>LGPLv2.1</a>
and its source can be downloaded <a href="/ffmpeg/ffmpeg-4.2.2.tar.bz2">here</a>.   

A copy of the LGPLv2.1 is also available in this repository [here](/ffmpeg/LICENSE).  

## Compilation Process
FFmpeg source code has **NOT** been modified for this software.  
FFmpeg has been compiled with the following configuration.  

```
ffmpeg version 4.2.2 Copyright (c) 2000-2019 the FFmpeg developers
  built with gcc 7 (GCC)
  configuration: --prefix=/home/ec2-user/ffmpeg_build --pkg-config-flags=--static --extra-cflags='-I/home/ec2-user/ffmpeg_build/include -static' --extra-ldflags='-L/home/ec2-user/ffmpeg_build/lib -static' --disable-debug --disable-doc --disable-ffplay --bindir=/home/ec2-user/bin
  libavutil      56. 31.100 / 56. 31.100
  libavcodec     58. 54.100 / 58. 54.100
  libavformat    58. 29.100 / 58. 29.100
  libavdevice    58.  8.100 / 58.  8.100
  libavfilter     7. 57.100 /  7. 57.100
  libswscale      5.  5.100 /  5.  5.100
  libswresample   3.  5.100 /  3.  5.100
```
FFmpeg has been compiled **without** `--enable-gpl` and `--enable-nonfree` in order to comply with the terms of [LGPLv2.1](/ffmpeg/LICENSE).  
You can have further details on the compilation process in the [Dockerfile](/Dockerfile) and in the [local build script](/build.sh) 

You can check that the `ffmpeg` single binary has no dynamic dependencies by
```
Admin:~/environment $ ldd ./ffmpeg
        not a dynamic executable
```

## Binaries
Standalone Binaries for FFmpeg and FFprobe compiled on Amazonlinux2 are available [here](/bin).  
These have been compiled with the same configuration set.

## Buy Me a Beer
If you found this useful, please feel free to buy me a beer or a coffee.  
[Monzo](https://monzo.me/giusebattista)

## Follow me on Twitter
You can find me on Twitter as [giusedroid](https://twitter.com/giusedroid)
