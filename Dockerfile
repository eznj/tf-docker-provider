FROM rust:latest AS build
WORKDIR /usr/src

RUN rustup target add x86_64-unknown-linux-musl
RUN rustup default nightly
COPY . ./

WORKDIR /usr/src/rocket-testfire
RUN rustup target add x86_64-unknown-linux-musl --toolchain nightly
RUN cargo build --release
WORKDIR /usr/src/rocket-testfire/target/release
USER 1000
EXPOSE 4499
CMD ["./rocket-testfire"]
