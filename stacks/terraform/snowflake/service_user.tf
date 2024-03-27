module "ci_dbt_playground_terraform_service_user" {
  source = "../modules/snowflake/service-user"
  providers = {
    snowflake.securityadmin = snowflake.securityadmin
    snowflake.useradmin     = snowflake.useradmin
  }

  environment       = "CI"
  project           = "DBT_PLAYGROUND"
  business_function = "TERRAFORM"
  comment           = "The service user for running Terraform on CI in dbt-playground."
  granted_role_name = "ACCOUNTADMIN"
}
