FROM rust:1.78 as build

#create a new empty shell project
RUN USER=root cargo new --bin rust_axum
WORKDIR /rust-axum-api

# copy over your manifests
COPY ./Cargo.lock ./Cargo.lock
COPY ./Cargo.toml ./Cargo.toml

RUN cargo build --release
RUN rm src/*.rs

COPY ./src ./src

RUN rm ./target/release/deps/rust_axum*
RUN cargo build --release


FROM debian:buster-slim
COPY --from=build /rust-axum-api/target/relase/rust_axum .

CMD ["./rust_axum"]

