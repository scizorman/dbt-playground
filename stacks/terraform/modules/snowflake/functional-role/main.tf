locals {
  role_name = "${var.environment}_${var.project}_${var.business_function}"
}

resource "snowflake_role" "this" {
  provider = snowflake.useradmin

  name    = local.role_name
  comment = var.comment
}

resource "snowflake_grant_account_role" "grant_this_to_sysadmin" {
  provider = snowflake.securityadmin

  role_name        = snowflake_role.this.name
  parent_role_name = "SYSADMIN"
}

resource "snowflake_grant_account_role" "grant_access_roles_to_this" {
  provider = snowflake.securityadmin

  for_each = toset(var.access_roles)

  role_name        = each.key
  parent_role_name = snowflake_role.this.name
}

resource "snowflake_grant_database_role" "grant_database_roles_to_this" {
  provider = snowflake.securityadmin

  for_each = toset(var.database_roles)

  database_role_name = each.key
  parent_role_name   = snowflake_role.this.name
}
