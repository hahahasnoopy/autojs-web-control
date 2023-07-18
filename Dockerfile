# Set the base image
FROM node:14
# 设置 npm 镜像源和 node-sass 镜像源为淘宝镜像

ENV NPM_CONFIG_REGISTRY=http://nexus.17usoft.com/repository/npm-all
ENV SASS_BINARY_SITE=https://npm.taobao.org/mirrors/node-sass/

# Create app directory in Docker
WORKDIR /usr/src/app 

# Install server dependencies
COPY packages/ ./packages/

COPY server/package*.json ./server/
WORKDIR /usr/src/app/server
RUN npm install

# Bundle server app source
COPY server/ ./

# Install web dependencies
WORKDIR /usr/src/app/web
COPY web/package*.json ./
RUN npm install

# Bundle web app source
COPY web/ ./

# Build the web project
RUN npm run build:prod

# Go back to server directory
WORKDIR /usr/src/app/server

# Your start command or add an entrypoint script into your package.json, such as "start": "node your-script.js"
CMD [ "npm", "start" ]

# Expose the port
EXPOSE 8080
