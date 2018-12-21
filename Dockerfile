FROM ubuntu:xenial

RUN apt-get update \
    && apt-get install -y \
        bind9 \
        curl \
        dnsutils \
        netcat \
        python-pip \
    && rm -rf /var/lib/apt/lists/* \
    && pip install ansible==2.5.2

RUN echo "nameserver 127.0.0.1" > /etc/resolv.conf
COPY . /opt/test
WORKDIR /opt/test

ENTRYPOINT [ "/usr/sbin/named",  "-f", "-u", "bind" ]
