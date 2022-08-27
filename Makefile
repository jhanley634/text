
# Copyright 2022 John Hanley. MIT licensed.

all: verify lint

ACTIVATE = source activate text
VERIFY = $(ACTIVATE) && infra/verify_imports.py && flake8

verify:
	$(VERIFY)
update-verify:
	time conda env update
	$(VERIFY)

lint:
	$(ACTIVATE) && isort . && flake8 && mpypy .

test:
	$(ACTIVATE) && python -m unittest
	$(ACTIVATE) && pytest

clean:
	rm -rf __pycache__ .pytest_cache .mypy_cache
