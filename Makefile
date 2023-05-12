
.PHONY: all clean
all: genfiles/yaml2json
clean:
	rm -rf ./genfiles
	rm -rf ./test/results
	rm -rf ./package

genfiles/yaml2json: test/results/success
	cp genfiles/yaml2json-pretest genfiles/yaml2json

test/results/success: genfiles/yaml2json-pretest $(shell find test/ -maxdepth 1)
	mkdir -p test/results
	./test/test.sh

genfiles/yaml2json-pretest: Makefile main.go
	go build -o genfiles/yaml2json-pretest .

.PHONY: package
package:
	$(MAKE) -C package


