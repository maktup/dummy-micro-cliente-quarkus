#-------------- [PESOS DE IMAGENES] -----------#
#  quay.io/quarkus/centos-quarkus-maven:21.0.0-java11  1.9GB
#  quay.io/quarkus/centos-quarkus-maven:19.2.0         1.5GB
#  jycr/maven-graalvm:3-jdk-11                         1.81GB
#-------------- [PESOS DE IMAGENES] -----------#

#//----------------------------------------------------------------//#
#//------------------------  [COMPILACION] ------------------------//#
#//----------------------------------------------------------------//#
#1. PARTIR DE LA 'IMAGEN PERSONALIZADA' NUESTRA: 
FROM maktup/ubuntu-maven-graalvm:v1.0

#2. VALIDAR EXISTENCIA DE 'JAVA':
RUN echo $JAVA_HOME
RUN java -version

#3. CREAR DIRECTORIO 'build' & 'src': 
WORKDIR /build
WORKDIR /build/src

#4. COPIAR ARCHIVO 'POM.xml' DENTRO DEL 'CONTENEDOR': 
COPY pom.xml /build

#5. COPIAR EL DIRECTORIO 'SRC' DENTRO DEL 'CONTENEDOR': 
COPY src /build/src

#6. EJECUTAR 'MAVEN' (RUTA DENTRO EL 'CONTENEDOR'):  
RUN mvn -f /build/pom.xml clean package

#7.  DOCUMENTANDO: 
MAINTAINER cesar guerra cesarricardo_guerra19@hotmail.com

#8. EXPONER PUERTO '8080': 
EXPOSE 8080

#9. COPIAR .JAR DE 'COMPILACION' A 'RUNTINE':  
COPY /build/target/*runner.jar app.jar

#10. LEVANTA EL 'MICROSERVICIO': 
ENTRYPOINT [ "java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "app.jar" ]