# Usamos una imagen oficial de Rust para construir el binario
FROM rust:1.78 as builder

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /usr/src/app

# Copiar los archivos Cargo.toml y Cargo.lock al contenedor
COPY Cargo.toml Cargo.lock ./

# Crear un directorio vacío para compilar dependencias
RUN mkdir src
RUN echo "fn main() {}" > src/main.rs

# Compilar las dependencias
RUN cargo build --release

# Copiar el resto del código fuente
COPY . .

# Compilar el proyecto
RUN cargo install --path .

# Crear la imagen final
FROM debian:buster-slim

# Crear un directorio para la aplicación
RUN mkdir -p /usr/src/app

# Copiar el binario compilado desde la imagen de compilación
COPY --from=builder /usr/local/cargo/bin/simple_server /usr/src/app

# Establecer el directorio de trabajo
WORKDIR /usr/src/app

# Exponer el puerto de la aplicación
EXPOSE 8080

# Ejecutar el binario
CMD ["./simple_server"]
