FROM docker/buildx-bin:0.12.0 as buildx
FROM node:20.11.0 as node
FROM summerwind/actions-runner-dind:v2.311.0-ubuntu-22.04
USER root
RUN set -ex; \
    apt-get update; \
    apt-get install -y \
    wget \
    openjdk-11-jdk maven
COPY --from=node /usr/lib /usr/lib
COPY --from=node /usr/local/lib /usr/local/lib
COPY --from=node /usr/local/include /usr/local/include
COPY --from=node /usr/local/bin /usr/local/bin
COPY --from=buildx /buildx /usr/libexec/docker/cli-plugins/docker-buildx
