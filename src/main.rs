use axum::{
    routing::get,
    response::Json,
    Router,
};
use std::net::SocketAddr;
use serde_json::json;


#[tokio::main]
async fn main() {
    let app = Router::new()
        .route("/", get(hello))
        .route("/health_check", get(health_check));

    let port = std::env::var("PORT")
        .ok()
        .and_then(|s| s.parse().ok())
        .unwrap_or(3000);

    let addr = SocketAddr::from(([127,0,0,1], port));

    println!("Server is running on: {} 🍋", addr);


    axum::Server::bind(&addr)
        .serve(app.into_make_service())
        .await
        .unwrap();

}

async fn health_check() -> Json<serde_json::Value> {
    const MESSAGE: &str = "Healt check: API is up and running smoothly";

    Json(json!({
        "status": "success",
        "message": MESSAGE
    }))
}

async fn hello() -> Json<serde_json::Value> {
    const MESSAGE: &str = "Hello, World!";

    Json(json!({
        "status": "success",
        "message": MESSAGE
    }))
}


