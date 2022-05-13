FROM --platform=amd64 node:16-alpine
WORKDIR /app
EXPOSE 3000
COPY package*.json ./
RUN npm ci
COPY . .
CMD npm run start