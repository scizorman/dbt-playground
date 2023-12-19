data "snowflake_role" "sysadmin" {
  name = "SYSADMIN"
}

resource "snowflake_role" "dbt_playground_admin" {
  name    = "DBT_PLAYGROUND_ADMIN"
  comment = "The role for administrators in dbt-playground."
}

resource "snowflake_role_grants" "grant_roles_to_sysadmin" {
  role_name              = data.snowflake_role.sysadmin.name
  roles                  = [snowflake_role.dbt_playground_admin.name]
  enable_multiple_grants = true
}
