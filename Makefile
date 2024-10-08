CRAWL_OUTPUT_PATH="./public/routes"

.PHONY: crawl
crawl:
	bash scripts/crawler.sh ${CRAWL_OUTPUT_PATH}

.PHONY: build-auto
build-auto:
	bash scripts/build.sh false

.PHONY: build-all
build-all:
	bash scripts/build.sh true
