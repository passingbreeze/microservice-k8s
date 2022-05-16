FROM --platform=amd64 node:16-alpine
WORKDIR /was
ENV STORE_SERVER_PORT=7777
COPY . .
RUN npm ci
EXPOSE ${STORE_SERVER_PORT}
CMD npm run start