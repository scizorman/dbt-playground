data "snowflake_database" "snowflake_sample_data" {
  name = "SNOWFLAKE_SAMPLE_DATA"
}

resource "snowflake_grant_privileges_to_role" "grant_snowflake_sample_data_usage_to_dbt_playground_dbt" {
  privileges = ["USAGE"]
  role_name  = snowflake_role.dbt_playground_dbt.name

  on_account_object {
    object_type = "DATABASE"
    object_name = data.snowflake_database.snowflake_sample_data.name
  }
}

resource "snowflake_grant_privileges_to_role" "grant_snowflake_sample_data_all_schema_monitor_and_usage_to_dbt_playground_dbt" {
  privileges = ["MONITOR", "USAGE"]
  role_name  = snowflake_role.dbt_playground_dbt.name

  on_schema {
    all_schemas_in_database = data.snowflake_database.snowflake_sample_data.name
  }
}

resource "snowflake_grant_privileges_to_role" "grant_snowflake_sample_data_tables_select_and_references_to_dbt_playground_dbt" {
  privileges = ["SELECT", "REFERENCES"]
  role_name  = snowflake_role.dbt_playground_dbt.name

  on_schema_object {
    all {
      object_type_plural = "TABLES"
      in_database        = data.snowflake_database.snowflake_sample_data.name
    }
  }
}
