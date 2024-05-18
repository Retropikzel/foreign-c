
set -eu
make clean
make build
make tmp

VERSION=$(cat VERSION)
