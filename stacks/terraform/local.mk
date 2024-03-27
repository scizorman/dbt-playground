include .env

export SNOWFLAKE_ACCOUNT := tk83970.ap-northeast-1.aws
export SNOWFLAKE_USER
export SNOWFLAKE_PASSWORD
export SNOWFLAKE_AUTHENTICATOR := Snowflake

terraform_command := aws-vault exec dbt-playground -- terraform
