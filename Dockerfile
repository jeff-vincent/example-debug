FROM golang:1.18
WORKDIR /
COPY . .
RUN go mod download
RUN go install github.com/go-delve/delve/cmd/dlv@latest
RUN CGO_ENABLED=0 go build -v -o app .
ENTRYPOINT [ "/go/bin/dlv" , "--listen=:2345", "--headless=true", "--api-version=2", "--accept-multiclient", "exec", "./app"]]
