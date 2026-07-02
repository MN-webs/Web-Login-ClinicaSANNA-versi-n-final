# --- Etapa 1: Compilación Manual del Backend ---
FROM openjdk:17-jdk-slim AS builder
WORKDIR /app

# 1. Copiar la estructura de directorios desde tu GitHub
COPY src/ ./src/
COPY web/ ./web/

# 2. Descargar el jar de Jakarta Servlet necesario para compilar tus Servlets
ADD https://repo1.maven.org/maven2/jakarta/servlet/jakarta.servlet-api/6.0.0/jakarta.servlet-api-6.0.0.jar /app/servlet-api.jar

# 3. Crear el directorio de salida y compilar todos tus archivos .java
RUN mkdir -p /app/classes && \
    find src -name "*.java" > sources.txt && \
    javac -cp /app/servlet-api.jar -d /app/classes @sources.txt

# --- Etapa 2: Servidor de Producción Tomcat ---
FROM tomcat:10.1-jre17-temurin-jammy
WORKDIR /usr/local/tomcat

# Limpiar las aplicaciones por defecto de Tomcat
RUN rm -rf webapps/*

# 1. Copiar las vistas estáticas y JSPs del Frontend a la raíz
COPY web/ webapps/ROOT/

# 2. Inyectar las clases del Backend compiladas en la Etapa 1 al directorio correcto de Tomcat
COPY --from=builder /app/classes/ webapps/ROOT/WEB-INF/classes/

# 3. Mapear dinámicamente el puerto asignado por Railway
CMD ["sh", "-c", "sed -i 's/port=\"8080\"/port=\"'\"$PORT\"'\"/g' conf/server.xml && catalina.sh run"]
