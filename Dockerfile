# --- Etapa 1: Compilación Nativa ---
FROM eclipse-temurin:17-jdk-jammy AS builder
WORKDIR /app

# Copiar el código fuente y las vistas
COPY src/ ./src/
COPY web/ ./web/

# Descargar la API de Servlets para poder compilar tus controladores
ADD https://repo1.maven.org/maven2/jakarta/servlet/jakarta.servlet-api/6.0.0/jakarta.servlet-api-6.0.0.jar /app/servlet-api.jar

# Compilar estructuralmente tolerando advertencias
RUN mkdir -p /app/classes && \
    javac -cp /app/servlet-api.jar -d /app/classes src/java/*/*.java src/java/*/*/*.java 2>/dev/null || \
    javac -cp /app/servlet-api.jar -d /app/classes $(find src -name "*.java")

# --- Etapa 2: Distribución en Tomcat ---
FROM tomcat:10.1-jre17-temurin-jammy
WORKDIR /usr/local/tomcat

# Limpiar entorno por defecto
RUN rm -rf webapps/*

# Copiar Frontend y Backend al contenedor final
COPY web/ webapps/ROOT/
COPY --from=builder /app/classes/ webapps/ROOT/WEB-INF/classes/

# Ajustar puerto dinámico de Railway
CMD ["sh", "-c", "sed -i 's/port=\"8080\"/port=\"'\"$PORT\"'\"/g' conf/server.xml && catalina.sh run"]
