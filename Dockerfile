ARG SCHEME=
FROM schemers/${SCHEME}
RUN apt-get update && apt-get install -y git make build-essential libffi-dev
RUN git clone https://git.sr.ht/~retropikzel/compile-r7rs && cd compile-r7rs && make install
COPY libtest.c /
RUN gcc -o libtest.so -shared -fPIC libtest.c && cp libtest.so /usr/local/lib/
RUN gcc -fPIC -c libtest.c && ar rcs libtest.a libtest.o && cp libtest.a /usr/local/lib


