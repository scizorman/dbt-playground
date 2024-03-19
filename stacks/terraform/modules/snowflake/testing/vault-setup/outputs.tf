output "snowflake_account" {
  description = "The Snowflake account identifier."
  value       = "tk83970.ap-northeast-1.aws"
}

output "snowflake_authenticator" {
  description = "The authentication type to use when connecting to Snowflake."
  value       = "JWT"
}

output "snowflake_user" {
  description = "The username of the user connecting to Snowflake."
  value       = "DBT_PLAYGROUND_TF_SNOW"
}

output "snowflake_private_key" {
  description = "The private key to use when connecting to Snowflake."
  value       = data.aws_secretsmanager_secret_version.dbt_playground_tf_snow_private_key.secret_string
  sensitive   = true
}

output "snowflake_private_key_passphrase" {
  description = "The passphrase of the private key to use when connecting to Snowflake."
  value       = data.aws_secretsmanager_secret_version.dbt_playground_tf_snow_private_key_passphrase.secret_string
  sensitive   = true
}
