.DELETE_ON_ERROR:

ifeq ($(CI),true)
else
include local.mk
endif

AWS_PROFILE := dbt-playground

aws_command       := $(if $(CI),aws,aws-vault exec $(AWS_PROFILE) -- aws)
terraform_command := $(if $(CI),terraform,aws-vault exec $(AWS_PROFILE) -- terraform)

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
init: $(STACK)/.terraform
%/.terraform:
	$(terraform_command) -chdir=$(@D) init -upgrade

.PHONY: show
show: $(STACK)/.terraform
	$(terraform_command) -chdir=$(<D) show

.PHONY: test
test: $(STACK)/.terraform
	$(terraform_command) -chdir=$(<D) test

.PHONY: validate
validate: $(STACK)/.terraform
	$(terraform_command) -chdir=$(<D) validate

.PHONY: plan
plan: validate
	$(terraform_command) -chdir=$(STACK) plan -detailed-exitcode

.PHONY: apply
apply: validate
	$(terraform_command) -chdir=$(STACK) apply

.PHONY: destroy
destroy: $(STACK)/.terraform
	$(terraform_command) -chdir=$(STACK) destroy -auto-approve=false
