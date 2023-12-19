resource "snowflake_warehouse" "dbt_playground_dev_xs" {
  name                                = "DBT_PLAYGROUND_DEV_XS_WH"
  auto_resume                         = true
  auto_suspend                        = 60
  comment                             = "The XS warehouse used in dbt-playground developments."
  initially_suspended                 = true
  query_acceleration_max_scale_factor = 8
  statement_timeout_in_seconds        = 300

  lifecycle {
    ignore_changes = [initially_suspended]
  }
}

resource "snowflake_grant_privileges_to_role" "grant_dbt_playground_dev_xs_warehouse_usage_to_dbt_playground_admin" {
  depends_on = [snowflake_warehouse.dbt_playground_dev_xs]

  privileges = ["USAGE"]
  role_name  = snowflake_role.dbt_playground_admin.name

  on_account_object {
    object_type = "WAREHOUSE"
    object_name = snowflake_warehouse.dbt_playground_dev_xs.name
  }
}

resource "snowflake_warehouse" "dbt_playground_dbt_xs" {
  name                                = "DBT_PLAYGROUND_DBT_XS_WH"
  auto_resume                         = true
  auto_suspend                        = 60
  comment                             = "The XS warehouse used by dbt in dbt-playground."
  initially_suspended                 = true
  query_acceleration_max_scale_factor = 8
  statement_timeout_in_seconds        = 300

  lifecycle {
    ignore_changes = [initially_suspended]
  }
}

resource "snowflake_grant_privileges_to_role" "grant_dbt_playground_dbt_xs_warehouse_privileges_to_dbt_playground_dbt" {
  depends_on = [snowflake_warehouse.dbt_playground_dbt_xs]

  privileges = ["USAGE"]
  role_name  = snowflake_role.dbt_playground_dbt.name

  on_account_object {
    object_type = "WAREHOUSE"
    object_name = snowflake_warehouse.dbt_playground_dbt_xs.name
  }
}
