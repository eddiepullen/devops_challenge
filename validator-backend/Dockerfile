FROM maven:3.6.3 AS maven
WORKDIR /usr/src/app
COPY . /usr/src/app

RUN export POSTGRES_HOST="${POSTGRES_HOST}"
RUN export POSTGRES_PORT="${POSTGRES_PORT}"
RUN export POSTGRES_DB="${POSTGRES_DB}"
RUN export POSTGRES_USERNAME="${POSTGRES_USERNAME}"
RUN export POSTGRE_PASSWORD="${POSTGRE_PASSWORD}"


RUN mvn clean install

FROM openjdk:8-jdk-alpine

ARG JAR_FILE=validator-0.0.1.jar 

WORKDIR /opt/app/

COPY --from=maven /usr/src/app/target/${JAR_FILE} /opt/app/

ENTRYPOINT ["java","-jar","validator-0.0.1.jar"]