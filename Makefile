
build:
	docker build . -t justmiles/sre_blog:latest

serve: build
	docker run -it -p 4000:4000 justmiles/sre_blog:latest
