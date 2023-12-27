data "snowflake_role" "sysadmin" {
  name = "SYSADMIN"
}

resource "snowflake_role" "dbt_playground_admin" {
  provider = snowflake.useradmin

  name    = "DBT_PLAYGROUND_ADMIN"
  comment = "The role for administrators in dbt-playground."
}

resource "snowflake_role" "dbt_playground_dbt" {
  provider = snowflake.useradmin

  name    = "DBT_PLAYGROUND_DBT"
  comment = "The role for dbt in dbt-playground."
}

resource "snowflake_role_grants" "grant_dbt_playground_admin_to_sysadmin" {
  provider = snowflake.useradmin

  role_name = snowflake_role.dbt_playground_admin.name
  roles     = [data.snowflake_role.sysadmin.name]
}

resource "snowflake_role_grants" "grant_dbt_playground_dev_xs_warehouse_usage_to_dbt_playground_admin" {
  provider = snowflake.useradmin

  role_name = snowflake_role.dbt_playground_dev_xs_warehouse_usage.name
  roles     = [snowflake_role.dbt_playground_admin.name]
}

resource "snowflake_role_grants" "grant_dbt_playground_dbt_to_dbt_playground_admin" {
  provider = snowflake.useradmin

  role_name = snowflake_role.dbt_playground_dbt.name
  roles     = [snowflake_role.dbt_playground_admin.name]
}

resource "snowflake_role_grants" "grant_dbt_playground_dbt_to_dbt_playground_tpch_database_readwrite" {
  provider = snowflake.useradmin

  role_name = snowflake_role.dbt_playground_database_read_write.name
  roles     = [snowflake_role.dbt_playground_dbt.name]
}

resource "snowflake_role_grants" "grant_dbt_playground_dbt_xs_warehouse_usage_to_dbt_playground_dbt" {
  provider = snowflake.useradmin

  role_name = snowflake_role.dbt_playground_dbt_xs_warehouse_usage.name
  roles     = [snowflake_role.dbt_playground_dbt.name]
}
