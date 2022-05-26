FROM node:14

COPY ["package.json", "yarn.lock", "/usr/src/"]

WORKDIR /usr/src

RUN npm i yarn && yarn install

COPY [".", "/usr/src/"]

EXPOSE 1337

CMD ["yarn", "develop"]
