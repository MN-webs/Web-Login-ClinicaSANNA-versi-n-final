# Usamos la imagen oficial y estable de Tomcat con Java 17
FROM tomcat:10.1-jre17-temurin-jammy
WORKDIR /usr/local/tomcat

# 1. Limpiar aplicaciones por defecto para evitar conflictos de rutas
RUN rm -rf webapps/*

# 2. Copiar todas tus vistas del Frontend (JSPs, HTML, CSS) directamente a la raíz de Tomcat
COPY web/ webapps/ROOT/

# 3. Copiar las clases compiladas del Backend (Servlets, Singleton, MVC) al directorio de ejecución de Tomcat
# Nota: NetBeans compila automáticamente tus archivos .java dentro de build/web/WEB-INF/classes
COPY build/web/WEB-INF/classes/ webapps/ROOT/WEB-INF/classes/

# 4. Copiar las librerías necesarias (.jar) si es que existen dentro de tu entorno de compilación
COPY build/web/WEB-INF/lib/ webapps/ROOT/WEB-INF/lib/

# 5. Mapear dinámicamente el puerto que Railway te asigne en tiempo de ejecución
CMD ["sh", "-c", "sed -i 's/port=\"8080\"/port=\"'\"$PORT\"'\"/g' conf/server.xml && catalina.sh run"]
