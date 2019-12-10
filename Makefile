
build:
	docker build . -t justmiles/sre_blog:latest

copy: clean
	docker create --name blog justmiles/sre_blog:latest
	docker cp -a blog:/blog/public ./public

serve: build
	docker run -it -p 4000:4000 justmiles/sre_blog:latest

clean: 
	rm -rf public
	docker rm -f blog 2>/dev/null || exit 0

deploy: build copy
	aws s3 sync public s3://milesmaddox.com --delete --acl public-read
	
travis-lint:
	docker run -v $(pwd):/project --rm skandyla/travis-cli lint .travis.yml

devsetup:
	if [ -s "$$HOME/.nvm/nvm.sh" ]; then \
		. "$$HOME/.nvm/nvm.sh"; \
		nvm install lts/boron; \
	fi
	
	npm install hexo-cli -g
	npm install