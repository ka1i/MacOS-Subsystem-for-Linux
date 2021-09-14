all: build

.PHONY: build
build:          ## build with native env.
	@cmake -B build -GNinja -S .
	@ninja -C build
	@make sign
	
.PHONY: sign
sign:	  	    ## sign Macos(must be).
	@codesign --entitlements linux_virtual_machine.entitlements -s - ./bin/linux_virtual_machine

.PHONY: clean
clean:          ## Clean build cache.
	@rm -rf bin
	@rm -rf lib
	@rm -rf build
	@echo "clean [ ok ]"
