FROM amd64/ubuntu:16.04

RUN apt-get update && \
    apt-get install -y \
    build-essential \
    libgmp-dev \
    libmpfr-dev \
    libmpc-dev \
    texinfo \
    libssl-dev \
    libgl1-mesa-dev \
    libx11-dev \
    libxext-dev \
    libxrender-dev \
    libxrandr-dev \
    libfltk1.3-dev \
    libsm-dev \
    libxinerama-dev \
    libxft-dev \
    libcairo2-dev \
    software-properties-common \
    wget \
    git \
    upx

# RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test && apt-get update && apt install -y gcc-9 g++-9 && \
#     rm -rf /var/lib/apt/lists/*

# RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 100 && \
#     update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 100

# RUN wget https://ftp.gnu.org/gnu/gcc/gcc-13.3.0/gcc-13.3.0.tar.gz && \
#     tar --checkpoint=.1000 -xzvf gcc-13.3.0.tar.gz

# RUN cd gcc-13.3.0 && ./contrib/download_prerequisites

# Альтернативный способ скачать так или иначе локально, проблема в доступе к
# http://gcc.gnu.org/pub/gcc/infrastructure/
# Поэтому в ./contrib/download_prerequisites используется зеркало
# https://ftp.mpi-inf.mpg.de/mirrors/gnu/mirror/gcc.gnu.org/pub/gcc/infrastructure/
# т.е. нужно заранее скачать архив и выполнить ./contrib/download_prerequisites
# если он долго висит, то надо использовать зеркала
# COPY ./gcc-13.3.0 /gcc-13.3.0

# RUN mkdir gcc13 && cd gcc13 && \
#     ../gcc-13.3.0/configure \
#     --enable-languages=c,c++ \
#     --disable-multilib \
#     --disable-bootstrap \
#     --disable-selftest \
#     --disable-lto \
#     --prefix=/opt/gcc-13 && \
#     make -j 8 && \
#     make install

# RUN update-alternatives --install /usr/bin/gcc gcc /opt/gcc-13/bin/gcc 100 && \
#     update-alternatives --install /usr/bin/g++ g++ /opt/gcc-13/bin/g++ 100

# RUN cd / && rm -rf gcc13 gcc-13.3.0.tar.xz gcc-13.3.0

ARG CMAKE_VERSION=4.1.2

# Тоже самое с CMake, может не работать сслыка на скачивание, поэтому ниже
# есть вариант с заранее скаченным архивом

# RUN wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}.tar.gz && \
#     tar -xzvf cmake-${CMAKE_VERSION}.tar.gz

COPY ./cmake-${CMAKE_VERSION} /cmake-${CMAKE_VERSION}

RUN cd cmake-${CMAKE_VERSION} && ./bootstrap && make && make install

#
RUN cd / && rm -rf cmake-${CMAKE_VERSION}.tar.gz cmake-${CMAKE_VERSION}
