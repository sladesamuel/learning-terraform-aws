SHELL := /bin/bash

.PHONY: install-hooks
install-hooks:
	SCRIPTS_DIR=./scripts scripts/install-hooks

.PHONY: init
init:
	scripts/init-state
	scripts/init-layer infra

.PHONY: validate
validate:
	scripts/validate-layers

.PHONY: infra
infra:
	scripts/apply-layer infra

.PHONY: destroy
destroy:
	scripts/destroy-layer infra

.PHONY: destroy-state
destroy-state:
	scripts/destroy-layer state

.PHONY: clean
clean:
	rm -rf **/.terraform **/.terraform.lock.hcl **/terraform.tfstate*

.PHONY: destroy-everything
destroy-everything:
	AUTO_APPROVE=true make destroy destroy-state clean
