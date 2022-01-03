
#1. PARTIR DE LA 'IMAGEN PERSONALIZADA' NUESTRA: 
FROM maktup/ubuntu-maven-graalvm:v1.0

#2. DOCUMENTAR: 
MAINTAINER cesar guerra cesarricardo_guerra19@hotmail.com

#3. VALIDAR EXISTENCIA DE 'JAVA' & 'MAVEN' (DENTRO DEL CONTENEDOR): 
RUN echo $JAVA_HOME
RUN java -version
RUN mvn -ver

#4. CREAR 'DIRECTORIOS' (DENTRO DEL CONTENEDOR): 
WORKDIR /build
WORKDIR /build/src
WORKDIR /build/target

RUN mkdir -p /build
RUN mkdir -p /build/src
RUN mkdir -p /build/target

#5. COPIAR ARCHIVO 'POM.xml' (DENTRO DEL CONTENEDOR): 
COPY pom.xml /build

#6. COPIAR EL DIRECTORIO 'SRC' (DENTRO DEL CONTENEDOR): 
COPY src /build/src

#7. EJECUTAR 'MAVEN' (DENTRO DEL CONTENEDOR):  
RUN mvn -f /build/pom.xml clean package

#8. EXPONER PUERTO '8080': 
EXPOSE 8080

#9. RENOMBRAR 'COMPILADO' (DENTRO DEL CONTENEDOR): 
RUN cp dummy-micro-cliente-quarkus-1.0.0-runner.jar app.jar
RUN rm dummy-micro-cliente-quarkus-1.0.0-runner.jar

#10. LISTAR CONTENIDO DE UBICACIÓN: 
RUN pwd
RUN ls -ltr

#11. INICIAR EL 'MICROSERVICIO': 
ENTRYPOINT [ "java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "app.jar" ]
