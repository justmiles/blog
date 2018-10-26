
build:
	docker build . -t justmiles/sre_blog:latest

serve: build
	docker run -it -p 4000:4000 justmiles/sre_blog:latest

deploy:
	hexo clean
	hexo generate
	aws s3 sync public s3://milesmaddox.com --delete --acl public-read
	
devsetup:
	if [ -s "$$HOME/.nvm/nvm.sh" ]; then \
		. "$$HOME/.nvm/nvm.sh"; \
		nvm install lts/boron; \
	fi
	
	npm install hexo-cli -g
	npm install