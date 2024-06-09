use actix_web::{post, web, App, HttpServer, Responder};
use serde::Deserialize;

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
    let server = HttpServer::new(|| {
        App::new()
            .service(print_message)
    })
    .bind("0.0.0.0:3006")?
    .run();
    println!("Server started at http://0.0.0.0:3006");

    server.await
}