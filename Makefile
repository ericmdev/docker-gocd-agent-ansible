.PHONY: build
build:
	docker-compose build

.PHONY: push
push:
	docker push myregistry:5000/gocd-agent:stable
