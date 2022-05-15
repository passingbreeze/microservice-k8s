FROM --platform=amd64 node:16-alpine
WORKDIR /was
COPY . .
RUN npm ci
EXPOSE 6666
CMD npm run start