.DELETE_ON_ERROR:

AWS_PROFILE := dbt-playground

aws_command       := $(if $(CI),aws,aws-vault exec $(AWS_PROFILE) -- aws)
terraform_command := $(if $(CI),terraform,aws-vault exec $(AWS_PROFILE) -- terraform)

secrets_dir                           := $(PWD)/secrets
snowflake_private_key_path            := $(secrets_dir)/dbt-playground-tf-snow-private-key
snowflake_private_key_passphrase_path := $(secrets_dir)/dbt-playground-tf-snow-private-key-passphrase

export TF_VAR_snowflake_private_key_path            := $(snowflake_private_key_path)
export TF_VAR_snowflake_private_key_passphrase_path := $(snowflake_private_key_passphrase_path)

.PHONY: all
all:
	@more $(MAKEFILE_LIST)

.PHONY: clean
clean:
	-rm -rf $(secrets_dir)
	find . -type d -name '.terraform' -exec rm -rf {} +

.PHONY: lint
lint:
	terraform fmt -check -diff -recursive

.PHONY: fmt
fmt:
	terraform fmt -recursive

.PHONY: init
init: $(STACK)/.terraform
%/.terraform: $(snowflake_private_key_path) $(snowflake_private_key_passphrase_path)
	$(terraform_command) -chdir=$(@D) init
$(snowflake_private_key_path):
	@mkdir -p $(@D)
	$(aws_command) secretsmanager get-secret-value \
		--secret-id dbt-playground/tf-snow-private-key \
		--query SecretString \
		--output text \
		> $@
$(snowflake_private_key_passphrase_path):
	@mkdir -p $(@D)
	$(aws_command) secretsmanager get-secret-value \
		--secret-id dbt-playground/tf-snow-private-key-passphrase \
		--query SecretString \
		--output text \
		> $@

.PHONY: show
show: $(STACK)/.terraform
	$(terraform_command) -chdir=$(<D) show

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
