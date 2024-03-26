module "dev_dbt_playground_dbt_functional_role" {
  source = "../modules/snowflake/functional-role"

  providers = {
    snowflake.securityadmin = snowflake.securityadmin
    snowflake.useradmin     = snowflake.useradmin
  }

  environment       = "DEV"
  project           = "DBT_PLAYGROUND"
  business_function = "DBT"
  comment           = "The functional role for dbt development environment in dbt-playground."
  access_roles = [
    module.dev_dbt_playground_dbt_wh_xs.usage_role_name,
  ]
  database_roles = [
    module.dev_dbt_playground_tpch_staging_db.reader_database_role_name,
    module.dev_dbt_playground_tpch_staging_db.writer_database_role_name,
    module.dev_dbt_playground_tpch_mart_db.reader_database_role_name,
    module.dev_dbt_playground_tpch_mart_db.writer_database_role_name,
  ]
}
