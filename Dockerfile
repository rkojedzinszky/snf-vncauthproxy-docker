FROM python:2-alpine
MAINTAINER Richard Kojedzinszky <krichy@nmdps.net>

ENV APP_USER=vncauthproxy \
    APP_HOME=/opt/vncauthproxy \
    APP_REVISION=1.7

RUN apk add --no-cache supervisor && \
    mkdir -p /data /opt && \
    adduser -D -h $APP_HOME $APP_USER

RUN apk add --no-cache -t .build-deps gcc libc-dev && \
    cd $APP_HOME && \
    pip install https://github.com/grnet/snf-vncauthproxy/archive/$APP_REVISION.tar.gz && \
    apk del .build-deps && \
    rm -rf /root/.cache

ADD assets /

WORKDIR $APP_HOME

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
