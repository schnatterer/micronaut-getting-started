FROM oracle/graalvm-ce:1.0.0-rc15 as graalvm
COPY . /home/app/micronaut-getting-started
WORKDIR /home/app/micronaut-getting-started
RUN native-image --no-server -cp target/micronaut-getting-started-*.jar

FROM frolvlad/alpine-glibc
EXPOSE 8080
COPY --from=graalvm /home/app/micronaut-getting-started .
ENTRYPOINT ["./micronaut-getting-started"]
