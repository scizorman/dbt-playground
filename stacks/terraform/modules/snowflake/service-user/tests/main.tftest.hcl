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
    business_function = "DBT"
    comment           = "The warehouse created in the Terraform test for dbt-playground."
  }
}

run "functional_role_setup" {
  module {
    source = "../functional-role"
  }

  variables {
    environment       = "TEST"
    project           = "DBT_PLAYGROUND"
    business_function = "DBT"
    comment           = "The functional role created in the Terraform test for dbt-playground."
    access_roles      = [run.warehouse_setup.usage_role_name]
  }
}

variables {
  environment       = "TEST"
  project           = "DBT_PLAYGROUND"
  business_function = "DBT"
  comment           = "The service user created in the Terraform test for dbt-playground."
}

run "resource_naming_validation" {
  variables {
    granted_role_name = run.functional_role_setup.name
  }

  assert {
    condition     = snowflake_user.this.name == "TEST_DBT_PLAYGROUND_DBT"
    error_message = "expected the service user name to be 'TEST_DBT_PLAYGROUND_DBT', got ${nonsensitive(snowflake_user.this.name)}"
  }
}

run "lowercase_environment_failure" {
  command = plan

  variables {
    environment       = "test"
    granted_role_name = run.functional_role_setup.name
  }

  expect_failures = [var.environment]
}

run "lowercase_project_failure" {
  command = plan

  variables {
    project           = "dbt_playground"
    granted_role_name = run.functional_role_setup.name
  }

  expect_failures = [var.project]
}

run "lowercase_business_function_failure" {
  command = plan

  variables {
    business_function = "dbt"
    granted_role_name = run.functional_role_setup.name
  }

  expect_failures = [var.business_function]
}
