## NetBSD

This readme is bit WIP.

I've got (foreign c) to run on NetBSD 10.0 with these commands

    su
    pkgin install gcc make wget git
    exit

    git clone https://github.com/ashinn/chibi-scheme.git
    cd chibi-scheme
    gmake PLATFORM=bsd
    su
    gmake PLATFORM=bsd install
    exit
    cd ..

    wget https://github.com/libffi/libffi/releases/download/v3.7.1/libffi-3.7.1.tar.gz
    tar -xf libffi-3.7.1.tar.gz
    cd libffi-3.7.1
    ./configure --prefix=/usr
    gmake
    su
    gmake install
    exit

    snow-chibi install --impls=chibi foreign.c


To make sure you can run the tests in this repo with:

    snow-chibi install --impls=chibi retropikzel.tap
    gmake SCHEME=chibi test
