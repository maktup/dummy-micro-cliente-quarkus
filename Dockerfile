#1. PARTIR DE LA 'IMAGEN PERSONALIZADA' NUESTRA: 
FROM maktup/ubuntu-maven-graalvm:v1.0

#2. DOCUMENTANDO: 
MAINTAINER cesar guerra cesarricardo_guerra19@hotmail.com

#3. VALIDAR EXISTENCIA DE 'JAVA':
RUN echo $JAVA_HOME
RUN java -version

#4. CREAR DIRECTORIO 'build' & 'src': 
WORKDIR /build
WORKDIR /build/src
WORKDIR /build/target

#5. COPIAR ARCHIVO 'POM.xml' DENTRO DEL 'CONTENEDOR': 
COPY pom.xml /build

#6. COPIAR EL DIRECTORIO 'SRC' DENTRO DEL 'CONTENEDOR': 
COPY src /build/src

#7. EJECUTAR 'MAVEN' (RUTA DENTRO EL 'CONTENEDOR'):  
RUN mvn -f /build/pom.xml clean package


COPY /build/target/dummy-micro-cliente-quarkus-1.0.0-runner.jar app.jar 


#9. EXPONER PUERTO '8080': 
EXPOSE 8080

#10. LEVANTA EL 'MICROSERVICIO': 
ENTRYPOINT [ "java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "app.jar" ]