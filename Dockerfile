#//----------------------------------------------------------------//#
#//------------------------  [COMPILACION] ------------------------//#
#//----------------------------------------------------------------//#
FROM maven:3-jdk-8-alpine as CONSTRUCTOR 

#1. CREA DIRECTORIO 'build':  
RUN mkdir -p /build

#2. DEFINIR UBICACION: 
WORKDIR /build

#3. COPIAR 'pom.xml' A DIRECTORIO 'build': 
COPY pom.xml /build

#4. DESCARGAR DEPENDENCIAS 'MAVEN': 
RUN mvn -B dependency:resolve dependency:resolve-plugins

#5. COPIAR 'src' A DIRECTORIO '/build/src': 
COPY src /build/src

#6. EJECUTAR 'MAVEN': 
RUN mvn clean package
