#-------------- [PESOS DE IMAGENES] -----------#
#  maven:3-jdk-8                        500MB 
#  maven:3-jdk-8-alpine                 122MB 
#  openjdk:8                            488MB
#  openjdk:8-slim                       284MB
#  openjdk:8-alpine                     105MB
#  openjdk:8-jdk-slim                   284MB 
#  openjdk:8-jdk-alpine                 105MB 
#  adoptopenjdk/openjdk8:alpine-slim    90.2MB
#  quay.io/quarkus/centos-quarkus-maven:21.0.0-java11  ???
#-------------- [PESOS DE IMAGENES] -----------#

#//----------------------------------------------------------------//#
#//------------------------  [COMPILACION] ------------------------//#
#//----------------------------------------------------------------//#
FROM quay.io/quarkus/centos-quarkus-maven:21.0.0-java11 as CONSTRUCTOR

#1. CREA DIRECTORIO 'build' & 'src': 
WORKDIR /build
WORKDIR /build/src

#2. SETEA COMO USUARIO 'ROOT': 
USER root

#3. BRINDANDO PERMISOS A DIRECTORIO BASE: 
RUN chown -R quarkus /build && chmod 775 /build && chown -R 1001 /build && chmod -R "g+rwX" /build && chown -R 1001:root /build

#4. COPIA ARCHIVO 'POM.xml' DENTRO DEL 'CONTENEDOR': 
COPY pom.xml /build

#4. COPIA EL DIRECTORIO 'SRC' DENTRO DEL 'CONTENEDOR': 
COPY src /build/src
 
USER root
#5. EJECUTAR 'MAVEN' (RUTA DENTRO EL 'CONTENEDOR'):  
RUN mvn -f /build/pom.xml clean package


#//----------------------------------------------------------------//#
#//-------------------------  [EJECUCION] -------------------------//#
#//----------------------------------------------------------------//#
FROM quay.io/quarkus/centos-quarkus-maven:21.0.0-java11 as RUNTIME 

#6. DOCUMENTANDO: 
MAINTAINER cesar guerra cesarricardo_guerra19@hotmail.com

#7. EXPONER PUERTO '8080': 
EXPOSE 8080

#8. COPIAR .JAR DE 'COMPILACION' A 'RUNTINE':  
COPY --from=CONSTRUCTOR /build/target/*runner.jar app.jar 

#9. IMPRIMIR UBICACION DEL JDK (graalvm): 
RUN which java && whereis java

USER root

#10. INSTALANDO 'SUDO, NANO, CURL':
#RUN yum install nano
#RUN yum install curl

#11. LEVANTA EL 'MICROSERVICIO': 
ENTRYPOINT [ "java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "app.jar" ]

