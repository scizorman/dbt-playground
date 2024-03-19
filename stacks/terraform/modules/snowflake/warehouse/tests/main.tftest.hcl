provider "snowflake" {
  account                = run.vault_setup.snowflake_account
  authenticator          = run.vault_setup.snowflake_authenticator
  user                   = run.vault_setup.snowflake_user
  private_key            = run.vault_setup.snowflake_private_key
  private_key_passphrase = run.vault_setup.snowflake_private_key_passphrase
}

provider "snowflake" {
  alias = "sysadmin"

  account                = run.vault_setup.snowflake_account
  authenticator          = run.vault_setup.snowflake_authenticator
  user                   = run.vault_setup.snowflake_user
  private_key            = run.vault_setup.snowflake_private_key
  private_key_passphrase = run.vault_setup.snowflake_private_key_passphrase
  role                   = "SYSADMIN"
}

provider "snowflake" {
  alias = "securityadmin"

  account                = run.vault_setup.snowflake_account
  authenticator          = run.vault_setup.snowflake_authenticator
  user                   = run.vault_setup.snowflake_user
  private_key            = run.vault_setup.snowflake_private_key
  private_key_passphrase = run.vault_setup.snowflake_private_key_passphrase
  role                   = "SECURITYADMIN"
}

provider "snowflake" {
  alias = "useradmin"

  account                = run.vault_setup.snowflake_account
  authenticator          = run.vault_setup.snowflake_authenticator
  user                   = run.vault_setup.snowflake_user
  private_key            = run.vault_setup.snowflake_private_key
  private_key_passphrase = run.vault_setup.snowflake_private_key_passphrase
  role                   = "USERADMIN"
}

run "vault_setup" {
  module {
    source = "../testing/vault-setup"
  }
}

variables {
  environment       = "TEST"
  project           = "DBT_PLAYGROUND"
  business_function = "ANALYST"
  comment           = "The warehouse created in the Terraform test for dbt-playground."
  warehouse_size    = "SMALL"
}

run "resource_naming_validation" {
  providers = {
    snowflake               = snowflake
    snowflake.sysadmin      = snowflake.sysadmin
    snowflake.securityadmin = snowflake.securityadmin
    snowflake.useradmin     = snowflake.useradmin
  }

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

  providers = {
    snowflake               = snowflake
    snowflake.sysadmin      = snowflake.sysadmin
    snowflake.securityadmin = snowflake.securityadmin
    snowflake.useradmin     = snowflake.useradmin
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
    snowflake.useradmin     = snowflake.useradmin
  }

  variables {
    project = "dbt_playground"
  }

  expect_failures = [var.project]
}

run "hyphen_in_project_failure" {
  command = plan

  providers = {
    snowflake               = snowflake
    snowflake.sysadmin      = snowflake.sysadmin
    snowflake.securityadmin = snowflake.securityadmin
    snowflake.useradmin     = snowflake.useradmin
  }

  variables {
    project = "DBT-PLAYGROUND"
  }

  expect_failures = [var.project]
}

run "lowercase_business_function_failure" {
  command = plan

  providers = {
    snowflake               = snowflake
    snowflake.sysadmin      = snowflake.sysadmin
    snowflake.securityadmin = snowflake.securityadmin
    snowflake.useradmin     = snowflake.useradmin
  }

  variables {
    business_function = "analyst"
  }

  expect_failures = [var.business_function]
}

run "hyphen_in_business_function_failure" {
  command = plan

  providers = {
    snowflake               = snowflake
    snowflake.sysadmin      = snowflake.sysadmin
    snowflake.securityadmin = snowflake.securityadmin
    snowflake.useradmin     = snowflake.useradmin
  }

  variables {
    business_function = "DATA-SCIENTIST"
  }

  expect_failures = [var.business_function]
}
