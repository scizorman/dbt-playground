terraform {
  required_version = "1.6.6"

  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "0.80.0"
    }
  }

  backend "s3" {}
}

provider "snowflake" {
  private_key            = file(var.snowflake_private_key_path)
  private_key_passphrase = var.snowflake_private_key_passphrase
}
