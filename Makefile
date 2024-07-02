ORG=mxfactorial
NAME=timescaledb-postgis

default: build

build:
	docker build -t $(ORG)/$(NAME):latest .

push:
	docker push $(ORG)/$(NAME):latest

.PHONY: default build push