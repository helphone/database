all: build

build:
	docker build -t helphone/database .
