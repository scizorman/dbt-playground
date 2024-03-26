terraform {
  required_version = "1.7.5"

  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "0.87.2"
    }
  }
}
