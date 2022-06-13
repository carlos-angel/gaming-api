FROM node:14

ARG UID
RUN groupmod -g 1001 node \
  && usermod -u 1001 -g 1001 node

RUN adduser -u ${UID} --disabled-password --gecos "" appuser
RUN mkdir /home/appuser/.ssh
RUN chown -R appuser:appuser /home/appuser/
RUN echo "StrictHostKeyChecking no" >> /home/appuser/.ssh/config
RUN npm i yarn && yarn install

RUN mkdir -p /appdata/www
COPY ["package.json", "yarn.lock", "/appdata/www/"]

USER appuser

WORKDIR /appdata/www