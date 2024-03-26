module "all_dbt_playground_analyst_wh_xs" {
  source = "../modules/snowflake/warehouse"
  providers = {
    snowflake.sysadmin      = snowflake.sysadmin
    snowflake.securityadmin = snowflake.securityadmin
    snowflake.useradmin     = snowflake.useradmin
  }

  environment       = "ALL"
  project           = "DBT_PLAYGROUND"
  business_function = "ANALYST"
  comment           = "The XS-size warehouse for analysts in dbt-playground."
}

module "dev_dbt_playground_dbt_wh_xs" {
  source = "../modules/snowflake/warehouse"
  providers = {
    snowflake.sysadmin      = snowflake.sysadmin
    snowflake.securityadmin = snowflake.securityadmin
    snowflake.useradmin     = snowflake.useradmin
  }

  environment       = "DEV"
  project           = "DBT_PLAYGROUND"
  business_function = "DBT"
  comment           = "The XS-size warehouse for dbt development environment in dbt-playground."
}
