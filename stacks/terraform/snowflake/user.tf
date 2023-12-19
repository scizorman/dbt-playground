resource "snowflake_role_grants" "grant_dbt_playground_admin_to_scizorman" {
  role_name = snowflake_role.dbt_playground_admin.name
  users     = ["SCIZORMAN"]
}
