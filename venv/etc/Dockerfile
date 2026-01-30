FROM docker.io/schemers/chibi:head
RUN apt-get update && apt-get install -y make gcc libffi-dev git ca-certificates curl xz-utils
WORKDIR /build
RUN git clone https://github.com/ashinn/chibi-scheme.git --depth=1
WORKDIR /build/chibi-scheme
RUN make
RUN make install
WORKDIR /build
RUN curl -o akku.tar.xz https://gitlab.com/-/project/6808260/uploads/094ce726ce3c6cf8c14560f1e31aaea0/akku-1.1.0.amd64-linux.tar.xz
RUN mkdir akku && tar -C akku --strip-components 1 -xf akku.tar.xz
WORKDIR /build/akku
RUN ./install.sh
WORKDIR /workdir
RUN ln -s /home/retropikzel/Projects/foreign-c/venv/bin/* /usr/local/bin/
#CMD ["bash", "--rcfile", "/home/retropikzel/Projects/foreign-c/venv/bin/activate"]
CMD ["bash"]
