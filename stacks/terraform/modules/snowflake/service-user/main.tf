resource "snowflake_user" "this" {
  provider = snowflake.useradmin

  lifecycle {
    ignore_changes = [
      password,
      rsa_public_key,
      rsa_public_key_2,
    ]
  }

  name              = "${var.environment}_${var.project}_${var.business_function}"
  comment           = var.comment
  default_role      = var.default_role
  default_warehouse = var.default_warehouse
}

resource "snowflake_grant_account_role" "this" {
  provider = snowflake.securityadmin

  role_name = var.granted_role_name
  user_name = snowflake_user.this.name
}
