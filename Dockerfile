#-------------- [PESOS DE IMAGENES] -----------#
#  quay.io/quarkus/centos-quarkus-maven:21.0.0-java11  1.9GB
#  quay.io/quarkus/centos-quarkus-maven:19.2.0         1.5GB
#  jycr/maven-graalvm:3-jdk-11                         1.81GB
#-------------- [PESOS DE IMAGENES] -----------#

#//----------------------------------------------------------------//#
#//------------------------  [COMPILACION] ------------------------//#
#//----------------------------------------------------------------//#
#FROM quay.io/quarkus/centos-quarkus-maven:19.2.0 as CONSTRUCTOR 
#FROM infinitenature/maven-graalvm-r:latest as CONSTRUCTOR 
FROM ghcr.io/graalvm/graalvm-ce:latest as CONSTRUCTOR 


#1. CREA DIRECTORIO 'build' & 'src': 
WORKDIR /build
WORKDIR /build/src

#2. SETEA COMO USUARIO 'ROOT': 
USER root

#3. BRINDANDO PERMISOS A DIRECTORIO BASE: 
#RUN chown -R quarkus /build && chmod 775 /build && chown -R 1001 /build && chmod -R "g+rwX" /build && chown -R 1001:root /build

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
#FROM quay.io/quarkus/centos-quarkus-maven:19.2.0 as RUNTIME 
#FROM infinitenature/maven-graalvm-r:latest as RUNTINE
FROM ghcr.io/graalvm/graalvm-ce:latest as RUNTIME 
 
#6. DOCUMENTANDO: 
MAINTAINER cesar guerra cesarricardo_guerra19@hotmail.com

#7. EXPONER PUERTO '8080': 
EXPOSE 8080

#8. COPIAR .JAR DE 'COMPILACION' A 'RUNTINE':  
COPY --from=CONSTRUCTOR /build/target/*runner.jar app.jar 

#9. IMPRIMIR UBICACION DEL JDK (graalvm): 
RUN which java && whereis java

#10. SETEA COMO USUARIO 'ROOT': 
USER root

#11. INSTALANDO 'SUDO, NANO, CURL, SIEGE':
RUN yum install sudo -y
RUN yum install nano -y
RUN yum install curl -y

#12. LEVANTA EL 'MICROSERVICIO': 
ENTRYPOINT [ "java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "app.jar" ]

