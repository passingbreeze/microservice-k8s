FROM --platform=amd64 node:16-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
EXPOSE 8888
CMD npm run start