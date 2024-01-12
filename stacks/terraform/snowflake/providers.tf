terraform {
  required_version = "1.6.6"

  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "0.83.1"
    }
  }

  backend "s3" {
    bucket = "dbt-playground-terraform-state"
    key    = "snowflake/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

provider "snowflake" {
  account                = local.snowflake_account
  authenticator          = local.snowflake_authenticator
  user                   = local.snowflake_user
  private_key            = local.snowflake_private_key
  private_key_passphrase = local.snowflake_private_key_passphrase
}

provider "snowflake" {
  alias = "securityadmin"

  account                = local.snowflake_account
  authenticator          = local.snowflake_authenticator
  user                   = local.snowflake_user
  private_key            = local.snowflake_private_key
  private_key_passphrase = local.snowflake_private_key_passphrase
  role                   = "SECURITYADMIN"
}

provider "snowflake" {
  alias = "useradmin"

  account                = local.snowflake_account
  authenticator          = local.snowflake_authenticator
  user                   = local.snowflake_user
  private_key            = local.snowflake_private_key
  private_key_passphrase = local.snowflake_private_key_passphrase
  role                   = "USERADMIN"
}

provider "snowflake" {
  alias = "sysadmin"

  account                = local.snowflake_account
  authenticator          = local.snowflake_authenticator
  user                   = local.snowflake_user
  private_key            = local.snowflake_private_key
  private_key_passphrase = local.snowflake_private_key_passphrase
  role                   = "SYSADMIN"
}
