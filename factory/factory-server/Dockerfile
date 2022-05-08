FROM --platform=amd64 rust:alpine3.15
EXPOSE 4000
WORKDIR /factory/server
COPY . .
RUN cargo install --path .
ENTRYPOINT ["RUST_LOG=trace", "server"]