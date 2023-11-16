.DELETE_ON_ERROR:

SHELL := /bin/bash

RYE := rye

.PHONY: all
all:
	@more $(MAKEFILE_LIST)

.PHONY: clean
clean:
	-rm -rf .venv

.venv: pyproject.toml .python-version requirements.lock requirements-dev.lock
	$(RYE) sync
	@touch $@
