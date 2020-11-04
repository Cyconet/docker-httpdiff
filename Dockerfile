FROM golang:alpine as builder

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

ENV GOPATH /gopath
ENV GOBIN /go/bin

# hadolint ignore=DL3017,DL3018
RUN apk --no-cache update && apk --no-cache upgrade && \
 # Install dependencies for building httpdiff 
 apk --no-cache add ca-certificates git && \
 # Build httpdiff client
 echo "Fetching httpdiff source" && \
 go get -d $UPSTREAM && \
WORKDIR $GOPATH/src/$UPSTREAM/
RUN git checkout $HTTPDIFF_VERSION && \
 echo "Getting dependancies" && \
 go get -d -v && \
 echo "Building httpdiff" && \
 CGO_ENABLED=0 go install -v -ldflags '-extldflags "-static"' $UPSTREAM

# start from scratch
FROM scratch
# Copy our static executable
COPY --from=builder /go/bin/httpdiff /go/bin/httpdiff

ENTRYPOINT ["/go/bin/httpdiff"]
#CMD [""]
