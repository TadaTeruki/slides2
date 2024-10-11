.PHONY: build-slide-auto
build-slide-auto:
	bash scripts/build.sh false

.PHONY: build-slide-all
build-slide-all:
	bash scripts/build.sh true

.PHONY: build
build: build-slide-auto
	pnpm build

.PHONY: resize-image
resize-image:
	bash scripts/resize-image.sh