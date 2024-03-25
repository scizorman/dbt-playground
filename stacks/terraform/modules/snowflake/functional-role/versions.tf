terraform {
  required_version = "1.7.4"

  required_providers {
    snowflake = {
      source                = "Snowflake-Labs/snowflake"
      version               = "0.87.2"
      configuration_aliases = [snowflake.securityadmin, snowflake.useradmin]
    }
  }
}
