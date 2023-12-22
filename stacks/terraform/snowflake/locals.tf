locals {
  snowflake_account                = "tk83970.ap-northeast-1.aws"
  snowflake_authenticator          = "JWT"
  snowflake_user                   = "DBT_PLAYGROUND_TF_SNOW"
  snowflake_private_key            = file(var.snowflake_private_key_path)
  snowflake_private_key_passphrase = trimspace(file(var.snowflake_private_key_passphrase_path))
}
