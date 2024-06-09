# Usamos una imagen oficial de Rust para construir el binario
FROM alpine:latest

# Instalar Rust y Cargo
RUN apk add --no-cache rust cargo

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /build

# Copiar el código fuente al contenedor
COPY . .

# Eliminar el archivo Cargo.lock
RUN rm Cargo.lock

# Compilar el proyecto en modo release
RUN cargo build --release --verbose

EXPOSE 3006

# Cambiar el ENTRYPOINT para ejecutar el binario compilado
CMD ["./target/release/simple_server"]
