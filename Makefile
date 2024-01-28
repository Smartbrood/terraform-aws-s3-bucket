SHELL := /bin/bash -euo pipefail

.PHONY: format_check init validate test format docs clean

format_check:
	terraform fmt -check

init: format_check
	terraform init

validate: init
	terraform validate

test: init
	terraform test

format:
	terraform fmt

docs: format
	terraform-docs markdown table --output-file README.md .

clean:
	rm -f .terraform.lock.hcl
	rm -rf .terraform