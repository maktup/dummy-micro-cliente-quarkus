FROM registry.access.redhat.com/ubi8/ubi-minimal:8.3
WORKDIR /work/
RUN chown 1001 /work \
    && chmod "g+rwX" /work \
    && chown 1001:root /work
COPY target /work/target

EXPOSE 8080
USER 1001

RUN apk add -u sudo 
RUN apk add -u nano
RUN apk add -u curl

CMD ["./target", "-Dquarkus.http.host=0.0.0.0"]
