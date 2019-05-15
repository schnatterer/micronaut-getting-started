FROM maven:3.6.0-jdk-8-alpine as mavencache
ENV MAVEN_OPTS=-Dmaven.repo.local=/mvn
COPY pom.xml /mvn/
WORKDIR /mvn
RUN mvn package dependency:resolve dependency:resolve-plugins

FROM oracle/graalvm-ce:1.0.0-rc15 as graalvm
ENV MAVEN_OPTS=-Dmaven.repo.local=/mvn
COPY --from=mavencache /mvn/ /mvn/

COPY . /home/app/micronaut-getting-started
WORKDIR /home/app/micronaut-getting-started
RUN ./mvnw package
RUN native-image --no-server -cp target/micronaut-getting-started-*.jar

FROM scratch
EXPOSE 8080
COPY --from=graalvm /home/app/micronaut-getting-started .
USER 1000
ENTRYPOINT ["./micronaut-getting-started"]
