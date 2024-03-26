provider "snowflake" {}

provider "snowflake" {
  alias = "sysadmin"

  role = "SYSADMIN"
}

provider "snowflake" {
  alias = "securityadmin"

  role = "SECURITYADMIN"
}

provider "snowflake" {
  alias = "useradmin"

  role = "USERADMIN"
}
