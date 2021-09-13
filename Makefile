all: build

.PHONY: build
build:          ## build with native env.
	@cmake -B build -GNinja -S .
	@ninja -C build


.PHONY: clean
clean:          ## Clean build cache.
	@rm -rf bin
	@rm -rf lib
	@rm -rf build
	@echo "clean [ ok ]"