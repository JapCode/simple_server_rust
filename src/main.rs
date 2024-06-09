use actix_web::{post, web, App, HttpServer, Responder};
use serde::Deserialize;
use std::env;

#[derive(Deserialize)]
struct MyPayload {
    message: String,
}

#[post("/print")]
async fn print_message(payload: web::Json<MyPayload>) -> impl Responder {
    println!("Received message: {}", payload.message);
    "Message printed in console"
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    // Obtener el puerto de la variable de entorno o usar 3006 como predeterminado
    let port = env::var("PORT").unwrap_or_else(|_| "3006".to_string());
    let addr = format!("0.0.0.0:{}", port);

    println!("Starting server at {}", addr);

    HttpServer::new(|| {
        App::new()
            .service(print_message)
    })
    .bind(addr)?
    .run()
    .await
}