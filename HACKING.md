
To run tests on different architecture than you are using, install podman and add the docker
registry to it's configuration. Add the line

    unqualified-search-registries = ["docker.io"]

to file: /etc/containers/registries.conf
