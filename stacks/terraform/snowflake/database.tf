resource "snowflake_database" "dbt_playground" {
  provider = snowflake.sysadmin

  name    = "DBT_PLAYGROUND"
  comment = "The database used in dbt-playground."
}

resource "snowflake_role" "dbt_playground_database_read_write" {
  provider = snowflake.useradmin

  name    = "DBT_PLAYGROUND_DATABASE_READ_WRITE"
  comment = "The role for read/write access to the database DBT_PLAYGROUND."
}

resource "snowflake_grant_privileges_to_role" "grant_dbt_playground_database_privileges_to_dbt_playground_database_read_write" {
  depends_on = [snowflake_database.dbt_playground]
  provider   = snowflake.securityadmin

  privileges = ["USAGE", "CREATE SCHEMA"]
  role_name  = snowflake_role.dbt_playground_database_read_write.name

  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.dbt_playground.name
  }
}

resource "snowflake_grant_privileges_to_role" "grant_dbt_playground_database_future_schemas_privileges_to_dbt_playground_database_read_write" {
  depends_on = [snowflake_database.dbt_playground]
  provider   = snowflake.securityadmin

  privileges = [
    "MODIFY",
    "MONITOR",
    "USAGE",
    "CREATE TABLE",
    "CREATE VIEW",
  ]
  role_name = snowflake_role.dbt_playground_database_read_write.name

  on_schema {
    future_schemas_in_database = snowflake_database.dbt_playground.name
  }
}

resource "snowflake_grant_privileges_to_role" "grant_dbt_playground_database_future_tables_privileges_to_dbt_playground_database_read_write" {
  depends_on = [snowflake_database.dbt_playground]
  provider   = snowflake.securityadmin

  privileges = ["SELECT", "INSERT", "UPDATE", "DELETE", "TRUNCATE", "REFERENCES"]
  role_name  = snowflake_role.dbt_playground_database_read_write.name

  on_schema_object {
    future {
      object_type_plural = "TABLES"
      in_database        = snowflake_database.dbt_playground.name
    }
  }
}

resource "snowflake_grant_privileges_to_role" "grant_dbt_playground_database_future_views_privileges_to_dbt_playground_database_read_write" {
  depends_on = [snowflake_database.dbt_playground]
  provider   = snowflake.securityadmin

  privileges = ["SELECT", "REFERENCES"]
  role_name  = snowflake_role.dbt_playground_database_read_write.name

  on_schema_object {
    future {
      object_type_plural = "VIEWS"
      in_database        = snowflake_database.dbt_playground.name
    }
  }
}
