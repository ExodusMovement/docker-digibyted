FROM ubuntu:18.04 as builder

ENV BUILD_TAG 6.16.5.1

RUN apt update
RUN apt install -y \
  build-essential \
  libtool \
  autotools-dev \
  automake \
  pkg-config \
  libssl-dev \
  libevent-dev \
  bsdmainutils \
  python3 \
  libboost-system-dev \
  libboost-filesystem-dev \
  libboost-chrono-dev \
  libboost-test-dev \
  libboost-thread-dev \
  wget

RUN wget -qO- https://github.com/digibyte/digibyte/archive/v$BUILD_TAG.tar.gz | tar xz && mv /digibyte-$BUILD_TAG /digibyte
WORKDIR /digibyte

RUN ./autogen.sh
RUN ./configure \
  --disable-shared \
  --disable-static \
  --disable-wallet \
  --disable-tests \
  --disable-bench \
  --enable-zmq \
  --with-utils \
  --without-miniupnpc \
  --without-libs \
  --without-gui
RUN make -j$(nproc)
RUN strip src/digibyted src/digibyte-cli

FROM ubuntu:18.04

RUN apt update
RUN apt install -y \
  libboost-system-dev \
  libboost-filesystem-dev \
  libboost-chrono-dev \
  libboost-test-dev \
  libboost-thread-dev \
  openssl \
  libevent-dev

COPY --from=builder /digibyte/src/digibyted /digibyte/src/digibyte-cli /usr/local/bin/

RUN groupadd --gid 1000 digibyted \
  && useradd --uid 1000 --gid digibyted --shell /bin/bash --create-home digibyted

USER digibyted

# P2P & RPC
EXPOSE 12024 14022

ENV \
  DIGIBYTED_DBCACHE=450 \
  DIGIBYTED_PAR=0 \
  DIGIBYTED_PORT=12024 \
  DIGIBYTED_RPC_PORT=14022 \
  DIGIBYTED_RPC_THREADS=4 \
  DIGIBYTED_ARGUMENTS=""

CMD exec digibyted \
  -dbcache=$DIGIBYTED_DBCACHE \
  -par=$DIGIBYTED_PAR \
  -port=$DIGIBYTED_PORT \
  -rpcport=$DIGIBYTED_RPC_PORT \
  -rpcthreads=$DIGIBYTED_RPC_THREADS \
  $DIGIBYTED_ARGUMENTS
