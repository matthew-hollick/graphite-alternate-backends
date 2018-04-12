FROM alpine:latest
RUN apk add --update --no-cache --virtual .confd-dependencies \
        go \
        git \
        gcc \
        musl-dev \
        make && \
    mkdir /go && export GOPATH=/go
RUN apk add py2-cairo ca-certificates py2-pip py-twisted libffi-dev python2-dev bash
RUN export PYTHONPATH="/opt/graphite/lib/:/opt/graphite/webapp/"
RUN pip install --upgrade \
        pip && \
    pip install --no-binary=:all: \
        https://github.com/graphite-project/whisper/tarball/master && \
    pip install --no-binary=:all: \
        https://github.com/graphite-project/carbon/tarball/master && \
    pip install --no-binary=:all: \
        biggraphite
RUN mkdir -p /var/log/carbon

RUN apk add --update --no-cache py2-pip bash
RUN pip install cqlsh
VOLUME ["/bg_init","/shared","/biggraphite"]
CMD /bg_init/init.sh