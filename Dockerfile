FROM node:18 as build

WORKDIR /app

COPY package.json ./
RUN yarn install --frozen-lockfile

COPY . .
RUN yarn build

FROM node:18-alpine

RUN yarn global add serve

WORKDIR /app

COPY --from=build /app/build .

EXPOSE 5000

CMD ["serve", "-s", ".","-|","5000"]

