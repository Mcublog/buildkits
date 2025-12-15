FROM i386/ubuntu:trusty-20180420

RUN apt-get update && \
    apt-get install -y \
    build-essential

RUN strings /usr/lib/i386-linux-gnu/libstdc++.so.6 | grep GLIBCXX