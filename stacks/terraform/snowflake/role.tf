resource "snowflake_role" "engineer" {
  name = "DBT_PLAYGROUND_ENGINEER"
}

resource "snowflake_grant_privileges_to_role" "grant_dbt_playground_dev_xs_warehouse_usage_to_engineer" {
  depends_on = [snowflake_warehouse.dev_xs]

  privileges = ["USAGE"]
  role_name  = snowflake_role.engineer.name

  on_account_object {
    object_type = "WAREHOUSE"
    object_name = snowflake_warehouse.dev_xs.name
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

resource "snowflake_role" "dbt" {
  name = "DBT_PLAYGROUND_DBT"
}

resource "snowflake_grant_privileges_to_role" "grant_tpch_database_to_dbt" {
  depends_on = [snowflake_database.tpch]

  privileges = ["USAGE", "CREATE SCHEMA"]
  role_name  = snowflake_role.dbt.name

  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.tpch.name
  }
}

resource "snowflake_grant_privileges_to_role" "grant_tpch_database_schema_to_dbt" {
  depends_on = [snowflake_database.tpch]

  privileges = [
    "MODIFY",
    "MONITOR",
    "USAGE",
    "CREATE TABLE",
    "CREATE VIEW",
  ]
  role_name = snowflake_role.dbt.name

  on_schema {
    future_schemas_in_database = snowflake_database.tpch.name
  }
}

resource "snowflake_grant_privileges_to_role" "grant_tpch_database_tables_to_dbt" {
  depends_on = [snowflake_database.tpch]

  privileges = ["SELECT", "INSERT", "UPDATE", "TRUNCATE", "REFERENCES"]
  role_name  = snowflake_role.dbt.name

  on_schema_object {
    future {
      object_type_plural = "TABLES"
      in_database        = snowflake_database.tpch.name
    }
  }
}

resource "snowflake_grant_privileges_to_role" "grant_tpch_database_views_to_dbt" {
  depends_on = [snowflake_database.tpch]

  privileges = ["SELECT", "REFERENCES"]
  role_name  = snowflake_role.dbt.name

  on_schema_object {
    future {
      object_type_plural = "VIEWS"
      in_database        = snowflake_database.tpch.name
    }
  }
}

resource "snowflake_grant_privileges_to_role" "grant_dbt_xs_warehouse_usage_to_dbt" {
  depends_on = [snowflake_warehouse.dbt_xs]

  privileges = ["USAGE"]
  role_name  = snowflake_role.dbt.name

  on_account_object {
    object_type = "WAREHOUSE"
    object_name = snowflake_warehouse.dbt_xs.name
  }
}
