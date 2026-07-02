# --- Etapa 1: Compilación Manual Dinámica ---
FROM eclipse-temurin:17-jdk-jammy AS builder
WORKDIR /app

# Copiar absolutamente todo el repositorio para no perder rutas
COPY . .

# Descargar la API de Servlets oficial
ADD https://repo1.maven.org/maven2/jakarta/servlet/jakarta.servlet-api/6.0.0/jakarta.servlet-api-6.0.0.jar /app/servlet-api.jar

# Crear la carpeta de clases, buscar CUALQUIER .java en el proyecto y compilarlo
RUN mkdir -p /app/classes && \
    find . -name "*.java" > fuentes.txt && \
    javac -cp /app/servlet-api.jar -d /app/classes @fuentes.txt

# --- Etapa 2: Servidor de Producción Tomcat ---
FROM tomcat:10.1-jre17-temurin-jammy
WORKDIR /usr/local/tomcat

# Limpiar las aplicaciones por defecto de Tomcat
RUN rm -rf webapps/*

# 1. Copiar las vistas y JSPs desde tu carpeta web a la raíz de Tomcat
COPY web/ webapps/ROOT/

# 2. Inyectar las clases compiladas dinámicamente en la etapa anterior
COPY --from=builder /app/classes/ webapps/ROOT/WEB-INF/classes/

# 3. Mapear dinámicamente el puerto asignado por Railway
CMD ["sh", "-c", "sed -i 's/port=\"8080\"/port=\"'\"$PORT\"'\"/g' conf/server.xml && catalina.sh run"]
