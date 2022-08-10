.PHONY: help
help: ## Help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
.DEFAULT_GOAL := help
build: ## Build all versions
	docker build --progress plain -t woperformance/nginx:php81-dev php8.1
	docker push woperformance/nginx:php81-dev