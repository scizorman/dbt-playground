locals {
  warehouse_name_size_suffixes = {
    "XSMALL"  = "XS"
    "SMALL"   = "S"
    "MEDIUM"  = "M"
    "LARGE"   = "L"
    "XLARGE"  = "XL"
    "2XLARGE" = "2XL"
    "3XLARGE" = "3XL"
    "4XLARGE" = "4XL"
    "5XLARGE" = "5XL"
    "6XLARGE" = "6XL"
  }

  warehouse_name = "${var.environment}_${var.project}_${var.business_function}_WH_${local.warehouse_name_size_suffixes[var.warehouse_size]}"
}

resource "snowflake_warehouse" "this" {
  provider = snowflake.sysadmin

  lifecycle {
    ignore_changes = [initially_suspended]
  }

  name    = local.warehouse_name
  comment = var.comment

  auto_resume                         = true
  auto_suspend                        = var.auto_suspend_seconds
  initially_suspended                 = true
  statement_queued_timeout_in_seconds = var.statement_queued_timeout_in_seconds
  statement_timeout_in_seconds        = var.statement_timeout_in_seconds
  warehouse_size                      = var.warehouse_size
  warehouse_type                      = var.warehouse_type
}

resource "snowflake_role" "this_usage" {
  provider = snowflake.useradmin

  name = "${local.warehouse_name}_USAGE"

  comment = "The role that has USAGE privilege on the warehouse ${local.warehouse_name}."
}

resource "snowflake_grant_privileges_to_account_role" "grant_usage_privilege_to_this_usage_role" {
  provider = snowflake.securityadmin

  account_role_name = snowflake_role.this_usage.name

  privileges = ["USAGE"]

  on_account_object {
    object_type = "WAREHOUSE"
    object_name = snowflake_warehouse.this.name
  }
}
