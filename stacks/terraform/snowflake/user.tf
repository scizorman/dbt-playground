resource "snowflake_role_grants" "grant_dbt_playground_admin_to_scizorman" {
  role_name = snowflake_role.dbt_playground_admin.name
  users     = ["SCIZORMAN"]
}

resource "snowflake_user" "dbt_playground_dbt" {
  name    = "DBT_PLAYGROUND_DBT"
  comment = "The user for dbt in dbt-playground."

  lifecycle {
    ignore_changes = [
      rsa_public_key,
    ]
  }
}

resource "snowflake_role_grants" "grant_dbt_playground_dbt_to_dbt_playground_dbt" {
  role_name = snowflake_role.dbt_playground_dbt.name
  users     = [snowflake_user.dbt_playground_dbt.name]
}
