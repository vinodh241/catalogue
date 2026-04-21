# FROM node:20
# WORKDIR /opt/server
# COPY package.json .
# COPY *.js .
# RUN npm install

# ENV MONGO="true" \
#     MONGO_URL="mongodb://mongodb:27017/catalogue" 
# CMD [ "node","server.js" ]

##################################################################

## docker optimization using minimal versions 

# FROM node:20-alpine3.21
# RUN addgroup -S roboshop && adduser -S roboshop -G roboshop
# WORKDIR /opt/server
# COPY package.json .
# COPY *.js .
# RUN npm install 
# RUN chown -R roboshop:roboshop /opt/server
# ENV MONGO="true" \
#     MONGO_URL="mongodb://mongodb:27017/catalogue"
# USER roboshop
# CMD ["node","server.js"]

#####################################################################

# docker multistage builds 
# stage-1 settingup env 
 FROM node:20-alpine3.21 AS builder 
 WORKDIR /opt/server
 COPY package.json .
 COPY *.js .
 RUN npm install 

# stage -2 downloading  from stage-1 and configuring the app 
 FROM node:20-alpine3.21
 RUN addgroup -S roboshop && adduser -S roboshop -G roboshop
 ENV MONGO="true" \
     MONGO_URL="mongodb://mongodb:27017/catalogue"
WORKDIR /opt/server
USER roboshop
COPY --from=builder /opt/server /opt/server/
CMD ["node","server.js"]
