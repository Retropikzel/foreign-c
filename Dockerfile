ARG IMPLEMENTATION
FROM schemers/$IMPLEMENTATION
ARG IMPLEMENTATION
WORKDIR /workdir
RUN if [ "${IMPLEMENTATION}" = "kawa" ]; then apt update && apt install -y curl zip unzip && apt clean; fi
RUN if [ "${IMPLEMENTATION}" = "kawa" ]; then bash -c "curl -s "https://get.sdkman.io" | bash && source $HOME/.sdkman/bin/sdkman-init.sh && sdk install java 22.0.2-tem"; fi
RUN if [ "${IMPLEMENTATION}" = "kawa" ]; then apt remove -y openjdk*; fi
ENV PATH=/root/.sdkman/candidates/java/22.0.2-tem/bin:$PATH
