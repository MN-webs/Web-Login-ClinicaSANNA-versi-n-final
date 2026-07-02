# --- Etapa 1: Compilación ---
FROM maven:3.8.8-eclipse-temurin-17 AS build
WORKDIR /app

# Copiar archivos esenciales
COPY pom.xml .
COPY src ./src

# Compilar omitiendo tests
RUN mvn clean package -DskipTests

# --- Etapa 2: Entorno de Ejecución (Tomcat Oficial Ligero) ---
FROM tomcat:10.1-jre17-temurin-jammy
WORKDIR /usr/local/tomcat

# Limpiar aplicaciones por defecto
RUN rm -rf webapps/*

# Copiar el archivo WAR generado en la etapa anterior
COPY --from=build /app/target/*.war webapps/ROOT.war

# Mapear dinámicamente el puerto de Railway
CMD ["sh", "-c", "sed -i 's/port=\"8080\"/port=\"'\"$PORT\"'\"/g' conf/server.xml && catalina.sh run"]
