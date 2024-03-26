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

run "warehouse_setup" {
  module {
    source = "../warehouse"
  }

  variables {
    environment       = "TEST"
    project           = "DBT_PLAYGROUND"
    business_function = "ANALYST"
    comment           = "The warehouse created in the Terraform test for dbt-playground."
  }
}

variables {
  environment       = "TEST"
  project           = "DBT_PLAYGROUND"
  business_function = "ANALYST"
  comment           = "The functional role created in the Terraform test for dbt-playground."
}

run "resource_naming_validation" {
  variables {
    access_roles = [run.warehouse_setup.usage_role_name]
  }

  assert {
    condition     = snowflake_role.this.name == "TEST_DBT_PLAYGROUND_ANALYST"
    error_message = "expected the functional role name to be TEST_DBT_PLAYGROUND_ANALYST, got ${snowflake_role.this.name}"
  }
}

run "lowercase_environment_failure" {
  command = plan

  variables {
    environment  = "test"
    access_roles = [run.warehouse_setup.usage_role_name]
  }

  expect_failures = [var.environment]
}

run "lowercase_project_failure" {
  command = plan

  variables {
    project      = "dbt_playground"
    access_roles = [run.warehouse_setup.usage_role_name]
  }

  expect_failures = [var.project]
}

run "lowercase_business_function_failure" {
  command = plan

  variables {
    business_function = "analyst"
    access_roles      = [run.warehouse_setup.usage_role_name]
  }

  expect_failures = [var.business_function]
}
