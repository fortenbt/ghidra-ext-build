FROM openjdk:18-jdk-slim-bullseye

ARG GRADLE_VERSION
ARG GHIDRA_VERSION
ARG GHIDRA_DATE

RUN apt-get update -y   \
 && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    unzip               \
    wget                \
 && apt-get clean       \
 && rm -rf /tmp/* /var/lib/apt/lists/*


RUN wget https://github.com/NationalSecurityAgency/ghidra/releases/download/Ghidra_${GHIDRA_VERSION}_build/ghidra_${GHIDRA_VERSION}_PUBLIC_${GHIDRA_DATE}.zip -P /tmp \
 && unzip -d /opt /tmp/ghidra_*.zip \
 && rm -f /tmp/ghidra_*.zip

RUN wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -P /tmp \
 && unzip -d /opt /tmp/gradle-*.zip \
 && rm -f /tmp/gradle-*.zip

ENV GRADLE_HOME=/opt/gradle-${GRADLE_VERSION}
ENV GHIDRA_INSTALL_DIR=/opt/ghidra_${GHIDRA_VERSION}_PUBLIC
ENV PATH="${GRADLE_HOME}/bin:${GHIDRA_INSTALL_DIR}:$PATH"
