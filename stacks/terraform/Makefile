ifeq ($(CI),true)
include ci.mk
else
include local.mk
endif

.PHONY: all
all:
	@more $(MAKEFILE_LIST)

.PHONY: clean
clean:
	find . -type d -name '.terraform' -exec rm -rf {} +

.PHONY: lint
lint:
	terraform fmt -check -diff -recursive

.PHONY: fmt
fmt:
	terraform fmt -recursive

.PHONY: init
init:
	$(terraform_command) -chdir=$(MODULE) init \
		-reconfigure \
		-upgrade

.PHONY: show
show: init
	$(terraform_command) -chdir=$(MODULE) show

.PHONY: test
test: init
	$(terraform_command) -chdir=$(MODULE) test

.PHONY: validate
validate: init
	$(terraform_command) -chdir=$(MODULE) validate

.PHONY: plan
plan: validate
	$(terraform_command) -chdir=$(MODULE) plan -detailed-exitcode

.PHONY: apply
apply: validate
	$(terraform_command) -chdir=$(MODULE) apply

.PHONY: destroy
destroy: init
	$(terraform_command) -chdir=$(MODULE) destroy -auto-approve=false
