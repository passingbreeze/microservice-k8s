FROM --platform=amd64 node:16-alpine
WORKDIR /app
ENV STOCKUP_PORT=8888
COPY . .
RUN npm ci
EXPOSE ${STOCKUP_PORT}
CMD npm run start