FROM ubuntu:16.04

# Third party UBUNTU PACKAGES:
RUN apt-get update -y && apt-get upgrade -y
# C++ compiler (e.g. GCC or Clang), autotools, autoconf-archive, libtool, pkg-config
RUN apt-get install -y git software-properties-common g++7 autotools-dev autoconf-archive libtool pkg-config libicu-dev libxml2-dev build-essential

# ticcutils [2] - A shared utility library
# dependencies
RUN apt-get install -y zlib1g-dev libbz2-dev libtar-dev libicu-dev
WORKDIR /git/ticcutils
RUN git clone https://github.com/LanguageMachines/ticcutils.git . && git fetch origin 5ad26d8a0fb5511a8a1c6ad3357ed6c3f2289ec2 && git reset --hard FETCH_HEAD
RUN sh bootstrap.sh && ./configure && make && make install

# libfolia [3] - A library for the FoLiA format
WORKDIR /git/libfolia
RUN git clone https://github.com/LanguageMachines/libfolia.git . && git fetch origin 27602e163af97dc4ccda8c15b1990fa5f1681b0a && git reset --hard FETCH_HEAD
RUN  bash bootstrap.sh && ./configure && make && make install

# uctodata [4.1]
WORKDIR /git/uctodata
RUN git clone https://github.com/LanguageMachines/uctodata.git . && git fetch origin 21d78e396b74d7f6a8cc34aa97efce84173adc65 && git reset --hard FETCH_HEAD
RUN  bash bootstrap.sh && ./configure && make && make install

# ucto [4.2] - A rule-based tokenizer
# dependencies
RUN apt-get install -y libexttextcat-dev
WORKDIR /git/ucto
RUN git clone https://github.com/LanguageMachines/ucto.git . && git fetch origin c475598ec5e1b14444b4fbc43d4757484562e0dd && git reset --hard FETCH_HEAD
RUN bash bootstrap.sh && ./configure && make && make install

# timbl [5] - The memory-based classifier engine
WORKDIR /git/timbl
RUN git clone https://github.com/LanguageMachines/timbl.git . && git fetch origin 1a695e887babe4dfc0dcace4e23a7996239b6a14 && git reset --hard FETCH_HEAD
RUN bash bootstrap.sh && ./configure && make && make install

# mbt [6] - The memory-based tagger
WORKDIR /git/mbt
RUN git clone https://github.com/LanguageMachines/mbt.git . && git fetch origin 06f1bfffb0cd6b527376ece06c4c8d24e1c78a6d && git reset --hard FETCH_HEAD
RUN bash bootstrap.sh && ./configure && make && make install

# frogdata [7] - Datafiles needed to run Frog
WORKDIR /git/frogdata
RUN git clone https://github.com/LanguageMachines/frogdata.git . && git fetch origin b04b0a79c521ab5cf1fff8ff1e6bf2c457e1621e && git reset --hard FETCH_HEAD
RUN bash bootstrap.sh && ./configure && make && make install

# Frog framework - C++ binaries
WORKDIR /git/frog
RUN git clone https://github.com/LanguageMachines/frog.git .
RUN git fetch origin d15adf3e851e817c11070948c7bc6a9493b71e4b
RUN git reset --hard FETCH_HEAD
RUN bash bootstrap.sh && ./configure && make && make install

# Frog python
# dependencies
RUN apt-get install -y cython cython3
WORKDIR /git/python-frog
RUN git clone https://github.com/proycon/python-frog.git . && git fetch origin a3ee0b9bafcf1ddd457e30b3fdf73141d8a6dd88 && git reset --hard FETCH_HEAD
RUN python3 setup.py install

WORKDIR /
RUN rm -rf /git

