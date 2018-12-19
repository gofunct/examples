# Build Stage
FROM colemanword/demoservice:1.11 AS build-stage

LABEL app="build-demoservice"
LABEL REPO="https://github.com/gofunct/demoservice"

ENV PROJPATH=/go/src/github.com/gofunct/demoservice

# Because of https://github.com/docker/docker/issues/14914
ENV PATH=$PATH:$GOROOT/bin:$GOPATH/bin

ADD . /go/src/github.com/gofunct/demoservice
WORKDIR /go/src/github.com/gofunct/demoservice

RUN make build-alpine

# Final Stage
FROM alpine

ARG GIT_COMMIT
ARG VERSION
LABEL REPO="https://github.com/gofunct/demoservice"
LABEL GIT_COMMIT=$GIT_COMMIT
LABEL VERSION=$VERSION

# Because of https://github.com/docker/docker/issues/14914
ENV PATH=$PATH:/opt/demoservice/bin

WORKDIR /opt/demoservice/bin

COPY --from=build-stage /go/src/github.com/gofunct/demoservice/bin/demoservice /opt/demoservice/bin/
RUN chmod +x /opt/demoservice/bin/demoservice

# Create appuser
RUN adduser -D -g '' demoservice
USER demoservice

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["/opt/demoservice/bin/demoservice"]
