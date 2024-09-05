ARG IMPLEMENTATION
FROM schemers/$IMPLEMENTATION
ARG IMPLEMENTATION
RUN echo "deb http://ftp.fi.debian.org/debian/ bookworm main" > /etc/apt/sources.list
WORKDIR /workdir
RUN echo 'this system will not be supported in the future' > /etc/unsupported-skip-usrmerge-conversion
#RUN echo debconf usrmerge/autoconvert select true | debconf-set-selections && apt-get update && apt-get -y install usrmerge
RUN sed -i 's/bullseye/bookworm/g' /etc/apt/sources.list
RUN apt update && apt full-upgrade -y && apt install -y make git curl wget zip unzip bash && apt clean
RUN apt full-upgrade -y
RUN cat /etc/issue
RUN if [ "$IMPLEMENTATION" = "kawa" ] ; then \
apt remove -y openjdk* --purge && apt autoremove -y && apt clean; \
curl -s "https://get.sdkman.io" | bash; \
bash -c "source ${HOME}/.sdkman/bin/sdkman-init.sh && sdk install java 22.0.2-tem"; \
cp -r ${HOME}/.sdkman/candidates/java/22.0.2-tem/bin/* /usr/local/bin; \
cp -r ${HOME}/.sdkman/candidates/java/22.0.2-tem/lib/* /usr/local/lib; \
sed -i 's/--no-console//' /usr/local/bin/kawa; \
fi
RUN if [ ! "$IMPLEMENTATION" = "guile" ] ; then apt install -y guile-3.0; fi
RUN git clone https://git.sr.ht/~retropikzel/schubert --depth=1 --branch=v0-16-3 && cd schubert && make && make install
RUN if [ "$IMPLEMENTATION" = "chicken" ] ; then chicken-install r7rs; fi
RUN if [ "$IMPLEMENTATION" = "racket" ] ; then raco pkg install --auto r7rs || true; fi
ARG WINE
RUN if [ "$WINE" = "true" ] ; then \
dpkg --add-architecture i386; \
mkdir -pm755 /etc/apt/keyrings; \
wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key; \
wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bookworm/winehq-bookworm.sources; \
apt update; \
apt install -y wine-binfmt --install-recommends winehq-stable; \
fi
ARG PACKAGES=curl
RUN apt update && apt install -y $PACKAGES
