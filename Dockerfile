FROM tomcat:10.1-jre17-temurin-jammy
WORKDIR /usr/local/tomcat

# Limpiar las aplicaciones por defecto de Tomcat para que no interfieran
RUN rm -rf webapps/*

# Copiar tu archivo WAR compilado directamente a la raíz de Tomcat
COPY ROOT.war webapps/ROOT.war

# Render usa el puerto 8080 por defecto para Tomcat
EXPOSE 8080

CMD ["catalina.sh", "run"]
