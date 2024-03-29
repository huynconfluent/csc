FROM ubuntu:20.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    git \
    curl \
    wget \
    httpie \
    jq \
    netcat \
    httpie \
    peco \
    vim \
    expect \
    ldap-utils \
    openssl \
    nmap \
    iputils-ping \
    kafkacat \
    openjdk-11-jdk \
    bsdmainutils \
    dnsutils \
    ldnsutils \
    && curl -sL --http1.1 https://cnfl.io/cli | sh -s -- -b /usr/local/bin latest \
    && curl -sL https://github.com/jiaqi/jmxterm/releases/download/v1.0.3/jmxterm-1.0.3-uber.jar > /usr/local/bin/jmxterm-1.0.3-uber.jar \
    && curl -sL https://testssl.sh > /usr/local/bin/testssl \
    && chmod +x /usr/local/bin/testssl \
    && git clone https://github.com/drwetter/testssl.sh /tmp/testssl \
    && mkdir -p /opt/testssl/etc \
    && cp -R /tmp/testssl/etc /opt/testssl \
    && mkdir -p /opt/ccloud-privatelink \
    && git clone https://github.com/confluentinc/ccloud-connectivity /tmp/ccloud-connectivity \
    && cp -R /tmp/ccloud-connectivity/privatelink /opt/ccloud-privatelink

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | tee /usr/share/keyrings/cloud.google.gpg \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    google-cloud-cli \
    azure-cli

ENV TESTSSL_INSTALL_DIR=/opt/testssl

CMD ["tail", "-f", "/dev/null"]
