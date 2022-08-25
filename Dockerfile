FROM golang:1.15

RUN go get github.com/x-motemen/blogsync

ENTRYPOINT [ "blogsync" ]
