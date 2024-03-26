locals {
  database_name = "${var.environment}_${var.project}_${var.data_layer}_DB"

  database_reader_privileges = ["USAGE"]
  database_writer_privileges = ["CREATE SCHEMA"]

  schema_reader_privileges = ["USAGE"]
  schema_writer_privileges = ["CREATE TABLE", "CREATE VIEW"]

  schema_object_reader_privileges = {
    "TABLES" = ["SELECT", "REFERENCES"]
    "VIEWS"  = ["SELECT", "REFERENCES"]
  }
  schema_object_writer_privileges = {
    "TABLES" = ["INSERT", "UPDATE", "DELETE", "TRUNCATE"]
  }
}

resource "snowflake_database" "this" {
  provider = snowflake.sysadmin

  name                        = local.database_name
  comment                     = var.comment
  data_retention_time_in_days = var.data_retention_time_in_days
  is_transient                = var.is_transient
}

resource "snowflake_database_role" "this_reader" {
  provider = snowflake.sysadmin

  database = snowflake_database.this.name
  name     = "${local.database_name}_READER"

  comment = "The database role that has read-only access to the database ${local.database_name}."
}

resource "snowflake_grant_privileges_to_database_role" "grant_database_reader_privileges_to_this_reader_role" {
  provider = snowflake.securityadmin

  database_role_name = "\"${snowflake_database.this.name}\".\"${snowflake_database_role.this_reader.name}\""

  on_database = snowflake_database.this.name
  privileges  = local.database_reader_privileges
}

resource "snowflake_grant_privileges_to_database_role" "grant_all_schema_reader_privileges_to_this_reader_role" {
  provider = snowflake.securityadmin

  database_role_name = "\"${snowflake_database.this.name}\".\"${snowflake_database_role.this_reader.name}\""

  on_schema {
    all_schemas_in_database = snowflake_database.this.name
  }

  privileges = local.schema_reader_privileges
}

resource "snowflake_grant_privileges_to_database_role" "grant_future_schema_reader_privileges_to_this_reader_role" {
  provider = snowflake.securityadmin

  database_role_name = "\"${snowflake_database.this.name}\".\"${snowflake_database_role.this_reader.name}\""

  on_schema {
    future_schemas_in_database = snowflake_database.this.name
  }

  privileges = local.schema_reader_privileges
}

resource "snowflake_grant_privileges_to_database_role" "grant_all_schema_objects_reader_privileges_to_this_reader_role" {
  provider = snowflake.securityadmin

  for_each = local.schema_object_reader_privileges

  database_role_name = "\"${snowflake_database.this.name}\".\"${snowflake_database_role.this_reader.name}\""

  on_schema_object {
    all {
      in_database        = snowflake_database.this.name
      object_type_plural = each.key
    }
  }

  privileges = each.value
}

resource "snowflake_grant_privileges_to_database_role" "grant_future_schema_objects_reader_privileges_to_this_reader_role" {
  provider = snowflake.securityadmin

  for_each = local.schema_object_reader_privileges

  database_role_name = "\"${snowflake_database.this.name}\".\"${snowflake_database_role.this_reader.name}\""

  on_schema_object {
    future {
      object_type_plural = each.key
      in_database        = snowflake_database.this.name
    }
  }

  privileges = each.value
}

resource "snowflake_database_role" "this_writer" {
  provider = snowflake.sysadmin

  database = snowflake_database.this.name
  name     = "${local.database_name}_WRITER"

  comment = "The database role that has write-only access to the database ${local.database_name}."
}

resource "snowflake_grant_privileges_to_database_role" "grant_database_writer_privileges_to_this_writer_role" {
  provider = snowflake.securityadmin

  database_role_name = "\"${snowflake_database.this.name}\".\"${snowflake_database_role.this_writer.name}\""

  on_database = snowflake_database.this.name
  privileges  = local.database_writer_privileges
}

resource "snowflake_grant_privileges_to_database_role" "grant_all_schema_writer_privileges_to_this_writer_role" {
  provider = snowflake.securityadmin

  database_role_name = "\"${snowflake_database.this.name}\".\"${snowflake_database_role.this_writer.name}\""

  on_schema {
    all_schemas_in_database = snowflake_database.this.name
  }

  privileges = local.schema_writer_privileges
}

resource "snowflake_grant_privileges_to_database_role" "grant_future_schema_writer_privileges_to_this_writer_role" {
  provider = snowflake.securityadmin

  database_role_name = "\"${snowflake_database.this.name}\".\"${snowflake_database_role.this_writer.name}\""

  on_schema {
    future_schemas_in_database = snowflake_database.this.name
  }

  privileges = local.schema_writer_privileges
}

resource "snowflake_grant_privileges_to_database_role" "grant_all_schema_objects_writer_privileges_to_this_writer_role" {
  provider = snowflake.securityadmin

  for_each = local.schema_object_writer_privileges

  database_role_name = "\"${snowflake_database.this.name}\".\"${snowflake_database_role.this_writer.name}\""

  on_schema_object {
    all {
      in_database        = snowflake_database.this.name
      object_type_plural = each.key
    }
  }

  privileges = each.value
}

resource "snowflake_grant_privileges_to_database_role" "grant_future_schema_objects_writer_privileges_to_this_writer_role" {
  provider = snowflake.securityadmin

  for_each = local.schema_object_writer_privileges

  database_role_name = "\"${snowflake_database.this.name}\".\"${snowflake_database_role.this_writer.name}\""

  on_schema_object {
    future {
      object_type_plural = each.key
      in_database        = snowflake_database.this.name
    }
  }

  privileges = each.value
}
