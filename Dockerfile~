ARG SCHEME=chibi
ARG IMAGE=${SCHEME}:head
FROM debian:trixie AS build
RUN apt-get update && apt-get install -y \
    gcc make git ca-certificates libffi-dev wget xz-utils
WORKDIR /build
RUN wget https://gitlab.com/-/project/6808260/uploads/094ce726ce3c6cf8c14560f1e31aaea0/akku-1.1.0.amd64-linux.tar.xz \
    && tar -xf akku-1.1.0.amd64-linux.tar.xz \
    && mv akku-1.1.0.amd64-linux akku
RUN git clone https://github.com/ashinn/chibi-scheme.git --depth=1
RUN git clone https://codeberg.org/retropikzel/compile-scheme.git --depth=1
WORKDIR /build/chibi-scheme
RUN make

ARG SCHEME=chibi
ARG IMAGE=${SCHEME}:head
FROM schemers/${IMAGE}
RUN mkdir -p ${HOME}/.snow && echo "()" > ${HOME}/.snow/config.scm
COPY --from=build /build /build
WORKDIR /build
RUN apt-get update && apt-get install -y gcc make libffi-dev libcurl4 gauche
WORKDIR /build/akku
RUN bash install.sh
ENV PATH=/root/.local/bin:${PATH}
RUN akku update
WORKDIR /build/chibi-scheme
RUN make install
WORKDIR /build/compile-scheme
RUN make build-gauche && make install
WORKDIR /workdir
ARG SCHEME=chibi
ENV COMPILE_R7RS=${SCHEME}
RUN if [ ! "${SCHEME}" = "racket" ]; then snow-chibi install --always-yes --impls=${SCHEME} "(srfi 64)"; fi
COPY Makefile .
COPY README.md .
COPY tests ./tests
COPY foreign ./foreign
