# --- Etapa 1: Compilación (Build) ---
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app

# Copiar configuración de dependencias y código fuente
COPY pom.xml .
COPY src ./src

# Compilar y empaquetar la aplicación omitiendo pruebas
RUN mvn clean package -DskipTests

# --- Etapa 2: Entorno de Ejecución (Tomcat) ---
FROM tomcat:10.1-jdk17-openjdk-slim
WORKDIR /usr/local/tomcat

# Limpiar aplicaciones por defecto de Tomcat
RUN rm -rf webapps/*

# Copiar el WAR generado a la raíz de Tomcat
COPY --from=build /app/target/*.war webapps/ROOT.war

# Mapear dinámicamente el puerto que asigna Railway
CMD ["sh", "-c", "sed -i 's/port=\"8080\"/port=\"'\"$PORT\"'\"/g' conf/server.xml && catalina.sh run"]
