FROM ubuntu:18.04

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
    iputils-ping

CMD ["tail", "-f", "/dev/null"]
