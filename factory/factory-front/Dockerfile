FROM --platform=amd64 node:16-alpine
WORKDIR /front
EXPOSE 3000
COPY package*.json ./
RUN npm ci
COPY . .
CMD npm run dev --host "0.0.0.0"
