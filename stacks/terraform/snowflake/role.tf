resource "snowflake_role" "engineer" {
  name = "DBT_PLAYGROUND_ENGINEER"
}

resource "snowflake_grant_privileges_to_role" "grant_dbt_playground_dev_xs_warehouse_usage_to_engineer" {
  privileges = ["USAGE"]
  role_name  = snowflake_role.engineer.name

  on_account_object {
    object_type = "WAREHOUSE"
    object_name = snowflake_warehouse.dev_xs_warehouse.name
  }
}

resource "snowflake_grant_privileges_to_role" "grant_scizorman_to_engineer" {
  privileges = ["MONITOR"]
  role_name  = snowflake_role.engineer.name

  on_account_object {
    object_type = "USER"
    object_name = "SCIZORMAN"
  }
}

resource "snowflake_role_grants" "grant_engineer" {
  role_name = snowflake_role.engineer.name
  users     = ["SCIZORMAN"]
}
