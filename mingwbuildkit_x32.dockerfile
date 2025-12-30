FROM mcublog/cmake_gcc_mingw

RUN apt-get update && \
    apt-get install -y \
    fluid \
    git

RUN git clone --depth 1 --branch release-1.3.11 https://github.com/fltk/fltk.git
COPY ./toolchain-cross-mingw32.cmake /fltk/toolchain-cross-mingw32.cmake

RUN cd fltk && mkdir build && cd build && cmake .. \
    -DCMAKE_TOOLCHAIN_FILE=../toolchain-cross-mingw32.cmake \
    -DCMAKE_INSTALL_PREFIX=/usr/i686-w64-mingw32 \
    -DOPTION_USE_OPENGL=OFF \
    -DOPTION_USE_GL=ON \
    -DOPTION_BUILD_EXAMPLES=OFF \
    -DOPTION_BUILD_TESTS=OFF

RUN cd /fltk/build && make -j 8 && make install && cd / && rm -rf fltk