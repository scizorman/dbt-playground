resource "snowflake_user" "dbt_playground_dbt" {
  provider = snowflake.useradmin

  name              = "DBT_PLAYGROUND_DBT"
  comment           = "The user for dbt in dbt-playground."
  default_role      = snowflake_role.dbt_playground_dbt.name
  default_warehouse = snowflake_warehouse.dbt_playground_dbt_xs.name

  lifecycle {
    ignore_changes = [
      rsa_public_key,
    ]
  }
}

resource "snowflake_role_grants" "grant_dbt_playground_dbt_to_dbt_playground_dbt" {
  provider = snowflake.useradmin

  role_name = snowflake_role.dbt_playground_dbt.name
  users     = [snowflake_user.dbt_playground_dbt.name]
}
