

install: F build
	launchd-register install build/downloads2trash \
		--start-interval 86400
	

build: F clean
	mkdir -p build
	cp -r bundle build/downloads2trash
	cargo build --release
	cp target/release/downloads2trash build/downloads2trash/downloads2trash


uninstall: F 


clean: F
	-rm -r build

F: ;