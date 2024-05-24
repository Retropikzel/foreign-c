
set -eu
set -o pipefail

make clean
make build
make tmp

VERSION=$(cat VERSION)
