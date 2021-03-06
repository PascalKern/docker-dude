FROM phusion/baseimage:0.10.2

ENV DUDE_VERSION=4.0beta3

ENV DUDE_STUFF=dude-install-$DUDE_VERSION.exe

COPY container/ /
COPY installer/$DUDE_STUFF /

RUN dpkg --add-architecture i386 \
  && add-apt-repository --yes ppa:ubuntu-wine/ppa \
  && apt-get -qq update \
  && apt-get -qq install --no-install-recommends \
       netcat \
       p7zip-full \
       wine1.8 \
       xvfb \
       > /dev/null \
  && 7z x -o/dude /$DUDE_STUFF > /dev/null \
  && chmod +x /dude/dude.exe \
  && apt-get -qq clean \
  && rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && rm --force /$DUDE_STUFF

CMD ["/sbin/my_init"]
