FROM golang:1.9 as build

WORKDIR /go/src/app
COPY . .


RUN go-wrapper download   # "go get -d -v ./..."
RUN go-wrapper install

RUN go build -o dlsapp ./


FROM gcr.io/distroless/base
WORKDIR /root/
COPY --from=0 /go/src/app/dlsapp .
COPY --from=0 /go/src/app/template/index.html ./template/index.html
COPY --from=0 /go/src/app/static/vendor/countdown.min.js ./static/vendor/countdown.min.js
COPY --from=0 /go/src/app/static/vendor/bootstrap/css/ ./static/vendor/bootstrap/css/
COPY --from=0 /go/src/app/static/vendor/bootstrap/fonts/ ./static/vendor/bootstrap/fonts/
COPY --from=0 /go/src/app/static/vendor/bootstrap/js/ ./statuc/vendor/bootstrap/js/
COPY --from=0 /go/src/app/static/css/ ./static/css/
COPY --from=0 /go/src/app/static/vendor/font-awesome/css/ ./static/vendor/font-awesome/css/
COPY --from=0 /go/src/app/static/vendor/font-awesome/fonts/ ./static/vendor/font-awesome/fonts/
COPY --from=0 /go/src/app/static/img/ep_naturalwhite.png ./static/img/ep_naturalwhite.png

CMD ["./dlsapp"]