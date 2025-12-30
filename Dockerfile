FROM node:20.19.5-alpine3.21 AS build
WORKDIR /opt/server
COPY *.json .
COPY *.js .
RUN npm install

FROM node:20.19.5-alpine3.21
WORKDIR /opt/server
RUN apk update && \
    apk upgrade --no-cache
EXPOSE 8080
LABEL com.project="roboshop" \
      component="cart"
RUN addgroup -S roboshop && adduser -S roboshop -G roboshop && \
    chown -R roboshop:roboshop /opt/server
ENV REDIS_HOST="redis" \
    CATALOGUE_HOST="catalogue" \
    CATALOGUE_PORT="8080"
COPY --from=build --chown=roboshop:roboshop /opt/server /opt/server
USER roboshop
ENTRYPOINT ["node","server.js"]

# FROM node:20.19.5-alpine3.21
# WORKDIR /opt/server
# EXPOSE 8080
# COPY *.json .
# COPY *.js .
# RUN npm install
# ENV REDIS_HOST="redis" \
#     CATALOGUE_HOST="catalogue" \
#     CATALOGUE_PORT="8080"
# CMD ["node","server.js"]