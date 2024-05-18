FROM rust:1.71 as build

RUN USER=root cargo new --bin rust_axum
WORKDIR /rust_axum

COPY ./Cargo.lock ./Cargo.lock
COPY ./Cargo.toml ./Cargo.toml
RUN cargo build --release

RUN rm src/*.rs
COPY ./src ./src

RUN rm ./target/release/deps/rust_axum*
RUN cargo build --release

FROM debian:buster-slim
COPY --from=build /rust_axum/target/release/rust_axum .

CMD ["./rust_axum"]
