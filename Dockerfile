FROM node:10-jessie

RUN npm install -g hexo-cli

COPY . /blog

WORKDIR /blog

RUN npm install && 	hexo clean && hexo generate --force

ENTRYPOINT ["/blog/entrypoint.sh"]

