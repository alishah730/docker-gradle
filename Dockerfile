FROM adoptopenjdk:8u262-b10-jdk-hotspot
#FROM ubuntu:latest

CMD ["gradle"]

ENV GRADLE_HOME /opt/gradle

RUN set -o errexit -o nounset \
    && echo "Adding gradle user and group" \
    && groupadd --system --gid 1000 gradle \
    && useradd --system --gid gradle --uid 1000 --shell /bin/bash --create-home gradle \
    && mkdir /home/gradle/.gradle \
    && chown --recursive gradle:gradle /home/gradle \
    \
    && echo "Symlinking root Gradle cache to gradle Gradle cache" \
    && ln -s /home/gradle/.gradle /root/.gradle

VOLUME /home/gradle/.gradle

WORKDIR /home/gradle

RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get install --yes --no-install-recommends \
        fontconfig \
        unzip \
        wget \
        openjdk-8-jdk\
        bzr \
        git \
        git-lfs \
        mercurial \
        openssh-client \
        subversion \
        apt-utils \
        vim \
        bash \
    && rm -rf /var/lib/apt/lists/*

ENV GRADLE_VERSION 6.6.1
ARG GRADLE_DOWNLOAD_SHA256=7873ed5287f47ca03549ab8dcb6dc877ac7f0e3d7b1eb12685161d10080910ac
RUN set -o errexit -o nounset \
    && echo "Downloading Gradle" \
    && wget --no-check-certificate --no-verbose --output-document=gradle.zip "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" \
     \
     && echo "Checking download hash" \
     && echo "${GRADLE_DOWNLOAD_SHA256} *gradle.zip" | sha256sum --check - \
    \
    && echo "Installing Gradle" \
    && unzip gradle.zip \
    && rm gradle.zip \
    && mv "gradle-${GRADLE_VERSION}" "${GRADLE_HOME}/" \
    && ln --symbolic "${GRADLE_HOME}/bin/gradle" /usr/bin/gradle \
    \
    && echo "Testing Gradle installation" \
    && gradle --version \
    && echo "Testing Git" \
    && git version
HEALTHCHECK NONE
ENV http_proxy ""
ENV https_proxy ""
ENV HTTP_PROXY ""
ENV HTTPS_PROXY ""
