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
  environment = "TEST"
  project     = "DBT_PLAYGROUND"
  data_layer  = "RAW"
  comment     = "The database created in the Terraform test for dbt-playground."
}

run "resource_naming_validation" {
  providers = {
    snowflake               = snowflake
    snowflake.sysadmin      = snowflake.sysadmin
    snowflake.securityadmin = snowflake.securityadmin
  }

  assert {
    condition     = snowflake_database.this.name == "TEST_DBT_PLAYGROUND_RAW_DB"
    error_message = "expected the database name to be TEST_DBT_PLAYGROUND_RAW_DB, got ${snowflake_database.this.name}"
  }

  assert {
    condition     = snowflake_database_role.this_reader.name == "TEST_DBT_PLAYGROUND_RAW_DB_READER"
    error_message = "expected the database reader role name to be TEST_DBT_PLAYGROUND_RAW_DB_READER, got ${snowflake_database_role.this_reader.name}"
  }

  assert {
    condition     = snowflake_database_role.this_writer.name == "TEST_DBT_PLAYGROUND_RAW_DB_WRITER"
    error_message = "expected the database writer role name to be TEST_DBT_PLAYGROUND_RAW_DB_WRITER, got ${snowflake_database_role.this_writer.name}"
  }
}

run "lowercase_environment_failure" {
  command = plan

  providers = {
    snowflake               = snowflake
    snowflake.sysadmin      = snowflake.sysadmin
    snowflake.securityadmin = snowflake.securityadmin
  }

  variables {
    environment = "test"
  }

  expect_failures = [var.environment]
}

run "lowercase_project_failure" {
  command = plan

  providers = {
    snowflake               = snowflake
    snowflake.sysadmin      = snowflake.sysadmin
    snowflake.securityadmin = snowflake.securityadmin
  }

  variables {
    project = "dbt_playground"
  }

  expect_failures = [var.project]
}

run "lowercase_data_layer_failure" {
  command = plan

  providers = {
    snowflake               = snowflake
    snowflake.sysadmin      = snowflake.sysadmin
    snowflake.securityadmin = snowflake.securityadmin
  }

  variables {
    data_layer = "raw"
  }

  expect_failures = [var.data_layer]
}
