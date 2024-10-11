CRAWL_OUTPUT_PATH="./public/routes"

.PHONY: crawl-slide
crawl-slide:
	bash scripts/crawler.sh ${CRAWL_OUTPUT_PATH}

.PHONY: build-slide-auto
build-slide-auto:
	bash scripts/build.sh false

.PHONY: build-slide-all
build-slide-all:
	bash scripts/build.sh true

.PHONY: build
build: build-slide-auto
	pnpm build