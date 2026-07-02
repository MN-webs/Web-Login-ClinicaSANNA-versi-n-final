# --- Una sola etapa: Servidor Tomcat de producción ---
FROM tomcat:10.1-jre17-temurin-jammy
WORKDIR /usr/local/tomcat

# 1. Limpiar aplicaciones por defecto para liberar espacio
RUN rm -rf webapps/*

# 2. Copiar únicamente tus archivos web (JSPs y HTMLs) a la raíz
COPY web/ webapps/ROOT/

# 3. Mapear dinámicamente el puerto que te da Railway
CMD ["sh", "-c", "sed -i 's/port=\"8080\"/port=\"'\"$PORT\"'\"/g' conf/server.xml && catalina.sh run"]
