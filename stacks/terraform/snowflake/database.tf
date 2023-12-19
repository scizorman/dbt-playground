resource "snowflake_database" "dbt_playground_tpch" {
  name    = "DBT_PLAYGROUND_TPCH"
  comment = "The TPC-H database used in dbt-playground."
}

resource "snowflake_grant_privileges_to_role" "grant_dbt_playground_tpch_database_privileges_to_dbt_playground_dbt" {
  depends_on = [snowflake_database.dbt_playground_tpch]

  privileges = ["USAGE", "CREATE SCHEMA"]
  role_name  = snowflake_role.dbt_playground_dbt.name

  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.dbt_playground_tpch.name
  }
}

resource "snowflake_grant_privileges_to_role" "grant_dbt_playground_tpch_database_future_schemas_privileges_to_dbt_playground_dbt" {
  depends_on = [snowflake_database.dbt_playground_tpch]

  privileges = [
    "MODIFY",
    "MONITOR",
    "USAGE",
    "CREATE TABLE",
    "CREATE VIEW",
  ]
  role_name = snowflake_role.dbt_playground_dbt.name

  on_schema {
    future_schemas_in_database = snowflake_database.dbt_playground_tpch.name
  }
}

resource "snowflake_grant_privileges_to_role" "grant_dbt_playground_tpch_database_future_tables_privileges_to_dbt_playground_dbt" {
  depends_on = [snowflake_database.dbt_playground_tpch]

  privileges = ["SELECT", "INSERT", "UPDATE", "DELETE", "TRUNCATE", "REFERENCES"]
  role_name  = snowflake_role.dbt_playground_dbt.name

  on_schema_object {
    future {
      object_type_plural = "TABLES"
      in_database        = snowflake_database.dbt_playground_tpch.name
    }
  }
}

resource "snowflake_grant_privileges_to_role" "grant_dbt_playground_tpch_database_future_views_privileges_to_dbt_playground_dbt" {
  depends_on = [snowflake_database.dbt_playground_tpch]

  privileges = ["SELECT", "REFERENCES"]
  role_name  = snowflake_role.dbt_playground_dbt.name

  on_schema_object {
    future {
      object_type_plural = "VIEWS"
      in_database        = snowflake_database.dbt_playground_tpch.name
    }
  }
}
