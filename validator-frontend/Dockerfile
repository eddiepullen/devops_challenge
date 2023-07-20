FROM node:16.3.0-alpine AS build

RUN export POSTGRES_HOST="${POSTGRES_HOST}"
RUN export POSTGRES_PORT="${POSTGRES_PORT}"
RUN export POSTGRES_DB="${POSTGRES_DB}"
RUN export POSTGRES_USERNAME="${POSTGRES_USERNAME}"
RUN export POSTGRE_PASSWORD="${POSTGRE_PASSWORD}"

WORKDIR /validator-frontend
COPY . .

RUN npm install 
RUN npm run build

FROM nginx:1.23

COPY --from=build /validator-frontend/build  /usr/share/nginx/html


EXPOSE 8081

CMD ["nginx", "-g", "daemon off;"]