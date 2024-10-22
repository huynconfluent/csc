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
    apt-transport-https \
    ca-certificates \
    gnupg

RUN curl -sL --http1.1 https://cnfl.io/cli | sh -s -- -b /usr/local/bin latest \
    && curl -sL https://github.com/jiaqi/jmxterm/releases/download/v1.0.3/jmxterm-1.0.3-uber.jar > /usr/local/bin/jmxterm-1.0.3-uber.jar \
    && curl -sL https://testssl.sh > /usr/local/bin/testssl \
    && chmod +x /usr/local/bin/testssl \
    && git clone https://github.com/drwetter/testssl.sh /tmp/testssl \
    && mkdir -p /opt/testssl/etc \
    && cp -R /tmp/testssl/etc /opt/testssl \
    && mkdir -p /opt/ccloud-privatelink \
    && git clone https://github.com/confluentinc/ccloud-connectivity /tmp/ccloud-connectivity \
    && cp -R /tmp/ccloud-connectivity/privatelink /opt/ccloud-privatelink

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - \
    && apt-get update -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    google-cloud-cli \
    azure-cli

RUN mkdir -p /tmp/confluent-hub \
    && curl -sL -o /tmp/confluent-hub-client-latest.tar.gz http://client.hub.confluent.io/confluent-hub-client-latest.tar.gz \
    && tar -xzf /tmp/confluent-hub-client-latest.tar.gz --directory /tmp/confluent-hub

ENV TESTSSL_INSTALL_DIR=/opt/testssl
ENV PATH="/tmp/confluent-hub/bin:${PATH}"

CMD ["tail", "-f", "/dev/null"]
