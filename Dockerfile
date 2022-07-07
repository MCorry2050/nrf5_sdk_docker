FROM ubuntu:20.04

MAINTAINER Marshall Corry <mcorry@entegix.com>

ENV SDK_ROOT=/opt/nordic

RUN apt-get update \
    && apt-get install -y lib32ncurses5 lib32z1 \
    && apt-get install -y gcc-arm-none-eabi \
    && apt-get install -y gdb-arm-none-eabi \
    && apt-get install -y build-essential \
    && apt-get install -y curl \
    && apt-get install -y make \
	&& apt-get install -y unzip \
		&& apt-get install -y wget

WORKDIR /
RUN wget -qO- https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2 | tar -xj
ENV PATH $PATH:/gcc-arm-none-eabi-10.3-2021.10/bin
WORKDIR /root/src

RUN mkdir -p /opt/nordic \
		&& wget https://developer.nordicsemi.com/nRF5_SDK/nRF5_SDK_v17.x.x/nRF5_SDK_17.1.0_ddde560.zip -O nordic_sdk.zip \
		&& unzip nordic_sdk.zip 'components/*' 'external/*' 'svd/*' -d $SDK_ROOT \
		&& rm nordic_sdk.zip

COPY Makefile.posix $SDK_ROOT/components/toolchain/gcc/Makefile.posix