FROM golang:1.8-alpine AS build

ADD . $GOPATH/src/github.com/ndecker/fritzbox_exporter

RUN apk add --no-cache git
ARG GOARCH=amd64
ARG GOARM=7
RUN CGO_ENABLED=0 go get -v github.com/ndecker/fritzbox_exporter &&\
    [ -f bin/linux_arm/fritzbox_exporter ] && mv bin/linux_arm/fritzbox_exporter bin || true

FROM scratch
COPY  --from=build /go/bin/fritzbox_exporter /fritzbox_exporter
EXPOSE 9133

ENTRYPOINT ["/fritzbox_exporter"]
CMD [""]

