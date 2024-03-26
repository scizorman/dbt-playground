provider "snowflake" {}

provider "snowflake" {
  alias = "sysadmin"

  role = "SYSADMIN"
}

provider "snowflake" {
  alias = "securityadmin"

  role = "SECURITYADMIN"
}

provider "snowflake" {
  alias = "useradmin"

  role = "USERADMIN"
}

variables {
  environment       = "TEST"
  project           = "DBT_PLAYGROUND"
  business_function = "ANALYST"
  comment           = "The warehouse created in the Terraform test for dbt-playground."
  warehouse_size    = "SMALL"
}

run "resource_naming_validation" {
  assert {
    condition     = snowflake_warehouse.this.name == "TEST_DBT_PLAYGROUND_ANALYST_WH_S"
    error_message = "expected the warehouse name to be TEST_DBT_PLAYGROUND_ANALYST_WH_S, got ${snowflake_warehouse.this.name}"
  }

  assert {
    condition     = snowflake_role.this_usage.name == "TEST_DBT_PLAYGROUND_ANALYST_WH_S_USAGE"
    error_message = "expected the warehouse usage role name to be TEST_DBT_PLAYGROUND_ANALYST_WH_S_USAGE, got ${snowflake_role.this_usage.name}"
  }
}

run "lowercase_environment_failure" {
  command = plan

  variables {
    environment = "test"
  }

  expect_failures = [var.environment]
}

run "lowercase_project_failure" {
  command = plan

  variables {
    project = "dbt_playground"
  }

  expect_failures = [var.project]
}

run "lowercase_business_function_failure" {
  command = plan

  variables {
    business_function = "analyst"
  }

  expect_failures = [var.business_function]
}
