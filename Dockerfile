FROM alpine:latest
LABEL maintainer "infiniteproject@gmail.com"

RUN addgroup -S icecast && \
    adduser -S icecast
RUN apk add dos2unix    
RUN apk add --update \
        icecast \
        mailcap && \
        rm -rf /var/cache/apk/*
RUN apk add --no-cache bash
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN dos2unix entrypoint.sh
EXPOSE 8000
RUN mkdir -p /var/log/icecast && \
    chown -R 100:101 /var/log/icecast 


ENTRYPOINT ["/entrypoint.sh"]
CMD icecast -c /etc/icecast.xml