# Usamos una distribución base distinta (Alpine) para saltar el bloqueo de red
FROM tomcat:10.1.34-jdk17-alpine
WORKDIR /usr/local/tomcat

# Limpiar aplicaciones por defecto
RUN rm -rf webapps/*

# Copiar tu carpeta web directamente a la raíz de Tomcat
COPY web/ webapps/ROOT/

# Configurar el puerto dinámico de Railway
CMD ["sh", "-c", "sed -i 's/port=\"8080\"/port=\"'\"$PORT\"'\"/g' conf/server.xml && catalina.sh run"]
