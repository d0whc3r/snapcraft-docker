FROM node:16

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN echo "deb http://ftp.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list \
    && echo "deb  http://deb.debian.org/debian stretch main contrib non-free" > /etc/apt/sources.list.d/stretch.list

RUN apt-get update \
    && apt-get install -yq \
         build-essential \
         dpkg-dev \
         wget \
         git \
         debhelper \
         pkg-config \
         python3-docopt \
         python3-fixtures \
         python3-jsonschema \
         python3-libarchive-c \
         python3-lxml \
         python3-magic \
         python3-progressbar \
         python3-pymacaroons \
         python3-requests-toolbelt \
         python3-responses \
         python3-simplejson \
         python3-setuptools \
         python3-tabulate \
         python3-testscenarios \
         python3-testtools \
         python3-xdg \
         python3-yaml \
         squashfs-tools \
         xdelta3 \
         git \
         bash-completion \
         python3-apt \
         python3-click \
         python3-debian \
         python3-pyramid \
         sudo \
         libelf1 libglib2.0-0 libglib2.0-bin libglib2.0-dev make \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ENV DEB_BUILD_OPTIONS=nocheck
RUN mkdir /snapcraft \
    && cd /snapcraft \
    && git clone https://github.com/snapcore/snapcraft \
    && wget http://de.archive.ubuntu.com/ubuntu/pool/main/p/python-petname/python3-petname_2.0-0ubuntu1_all.deb \
    && dpkg -i python3-petname_2.0-0ubuntu1_all.deb \
    && wget http://de.archive.ubuntu.com/ubuntu/pool/universe/p/pysha3/python3-pysha3_1.0.0-0ubuntu1_amd64.deb \
    && dpkg -i python3-pysha3_1.0.0-0ubuntu1_amd64.deb \
    && cd snapcraft \
    && dpkg-buildpackage -us -uc \
    && dpkg -i ../snapcraft_*.deb

USER node

WORKDIR /app
