# Simple wrapper that calls make in the build directory

MAKEFLAGS=--no-print-directory

all:

test: all
test: RABBITS_DYNLIB_PATH=$(shell ./repos print-dynlib-path)
export RABBITS_DYNLIB_PATH

%:
	@$(MAKE) -C $$(./repos build-dir) $*
