FROM alpine:3.8

# Dockerfile Maintainer
MAINTAINER Jan Wagner "waja@cyconet.org"

ARG BUILD_DATE
ARG BUILD_VERSION
ARG VCS_URL
ARG VCS_REF
ARG VCS_BRANCH

# See http://label-schema.org/rc1/ and https://microbadger.com/labels
LABEL org.label-schema.name="httpdiff - diff http requests" \
    org.label-schema.description="Perform the same request against two HTTP servers and diff the results on Alpine Linux based container" \
    org.label-schema.vendor="Cyconet" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.build-date="${BUILD_DATE:-unknown}" \
    org.label-schema.version="${BUILD_VERSION:-unknown}" \
    org.label-schema.vcs-url="${VCS_URL:-unknown}" \
    org.label-schema.vcs-ref="${VCS_REF:-unknown}" \
    org.label-schema.vcs-branch="${VCS_BRANCH:-unknown}"

ENV HTTPDIFF_VERSION master
ENV UPSTREAM github.com/jgrahamc/httpdiff

ENV GOROOT /usr/lib/go
ENV GOPATH /gopath
ENV GOBIN /gopath/bin
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin

RUN apk --no-cache update && apk --no-cache upgrade && \
 # Install dependencies for building httpdiff 
 apk --no-cache add ca-certificates && \
 apk --no-cache add --virtual build-dependencies curl git go musl-dev && \
 # Install httpdiff client
 echo "Starting installing httpdiff." && \
 go get -d $UPSTREAM && \
 cd $GOPATH/src/$UPSTREAM/ && git checkout $HTTPDIFF_VERSION && \
 go install $UPSTREAM && \
 apk del build-dependencies

ENTRYPOINT ["/gopath/bin/httpdiff"]
#CMD [""]
