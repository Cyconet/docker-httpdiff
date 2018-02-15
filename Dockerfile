FROM alpine:3.7

# Dockerfile Maintainer
MAINTAINER Jan Wagner "waja@cyconet.org"

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
