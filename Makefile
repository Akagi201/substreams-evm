ENDPOINT ?= mainnet.eth.streamingfast.io:443
START_BLOCK ?= 12292922
STOP_BLOCK ?= +1

.PHONY: all
all: help

.PHONY: build # cargo build
build:
	cargo build --target wasm32-unknown-unknown --release

.PHONY: map_transfers # substreams run map_transfers
map_transfers: build
	substreams run -e $(ENDPOINT) substreams.yaml map_transfers -s $(START_BLOCK) -t $(STOP_BLOCK)

.PHONY: store_transfers # substreams run store_transfers
store_transfers: build
	substreams run -e $(ENDPOINT) substreams.yaml store_transfers -s $(START_BLOCK) -t $(STOP_BLOCK)

.PHONY: codegen # substreams protogen
codegen:
	substreams protogen ./substreams.yaml --exclude-paths="sf/substreams,google"

.PHONY: package # substreams package
package: build
	substreams package substreams.yaml

.PHONY: help # generate list of targets with descriptions
help:
	@grep '^.PHONY: .* #' Makefile | sed 's/\.PHONY: \(.*\) # \(.*\)/\1	\2/' | expand -t20
