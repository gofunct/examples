# Build Stage
FROM colemanword/simple:1.11 AS build-stage

LABEL app="build-simple"
LABEL REPO="https://github.com/gofunct/simple"

ENV PROJPATH=/go/src/github.com/gofunct/simple

# Because of https://github.com/docker/docker/issues/14914
ENV PATH=$PATH:$GOROOT/bin:$GOPATH/bin

ADD . /go/src/github.com/gofunct/simple
WORKDIR /go/src/github.com/gofunct/simple

RUN make build-alpine

# Final Stage
FROM alpine

ARG GIT_COMMIT
ARG VERSION
LABEL REPO="https://github.com/gofunct/simple"
LABEL GIT_COMMIT=$GIT_COMMIT
LABEL VERSION=$VERSION

# Because of https://github.com/docker/docker/issues/14914
ENV PATH=$PATH:/opt/simple/bin

WORKDIR /opt/simple/bin

COPY --from=build-stage /go/src/github.com/gofunct/simple/bin/simple /opt/simple/bin/
RUN chmod +x /opt/simple/bin/simple

# Create appuser
RUN adduser -D -g '' simple
USER simple

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["/opt/simple/bin/simple"]
