FROM alpine:3.5

# Dockerfile Maintainer
MAINTAINER Jan Wagner "waja@cyconet.org"

ENV GOROOT /usr/lib/go
ENV GOPATH /gopath
ENV GOBIN /gopath/bin
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin

# Install dependencies for building httpdiff 
RUN apk --no-cache add ca-certificates && \
 apk --no-cache add --virtual build-dependencies curl git go && \
 # Install httpdiff client
 echo "Starting installing httpdiff." && \
 go get github.com/jgrahamc/httpdiff && \
 go install github.com/jgrahamc/httpdiff && \
 apk del build-dependencies

ENTRYPOINT ["/gopath/bin/httpdiff"]
#CMD [""]
