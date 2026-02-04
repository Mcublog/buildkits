FROM amd64/centos:7

RUN sed -i \
  -e 's|^mirrorlist=|#mirrorlist=|g' \
  -e 's|^#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' \
  /etc/yum.repos.d/CentOS-Base.repo

RUN yum install -y \
    gcc \
    gcc-c++ \
    binutils \
    make \
    git \
    && yum clean all

ARG CMAKE_VERSION=4.1.2
COPY ./cmake-${CMAKE_VERSION} /cmake-${CMAKE_VERSION}

RUN cd cmake-${CMAKE_VERSION} && ./bootstrap -- -DCMAKE_USE_OPENSSL=OFF && make && make install
