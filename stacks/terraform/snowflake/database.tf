module "dev_dbt_playground_tpch_staging_db" {
  source = "../modules/snowflake/database"
  providers = {
    snowflake.sysadmin      = snowflake.sysadmin
    snowflake.securityadmin = snowflake.securityadmin
  }

  environment = "DEV"
  project     = "DBT_PLAYGROUND_TPCH"
  data_layer  = "STAGING"
  comment     = "The development database to store staging TPC-H data in dbt-playground."

  data_retention_time_in_days = 0
  is_transient                = true
}

module "dev_dbt_playground_tpch_mart_db" {
  source = "../modules/snowflake/database"
  providers = {
    snowflake.sysadmin      = snowflake.sysadmin
    snowflake.securityadmin = snowflake.securityadmin
  }

  environment = "DEV"
  project     = "DBT_PLAYGROUND_TPCH"
  data_layer  = "MART"
  comment     = "The development database for the data mart to store TPC-H data in dbt-playground."

  data_retention_time_in_days = 0
  is_transient                = true
}
