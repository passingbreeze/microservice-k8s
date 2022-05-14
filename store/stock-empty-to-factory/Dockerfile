FROM --platform=amd64 node:16-alpine
WORKDIR /was
COPY . .
RUN npm ci
EXPOSE 7777
CMD npm run start