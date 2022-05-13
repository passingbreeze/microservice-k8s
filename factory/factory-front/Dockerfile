FROM --platform=amd64 node:16-alpine
WORKDIR /front
EXPOSE 8080
COPY . .
RUN npm ci
CMD npm run start --host "0.0.0.0"
