FROM node:boron-alpine

RUN npm install -g hexo-cli

COPY . blog

RUN cd blog && npm install

ENTRYPOINT ["blog/entrypoint.sh"]

