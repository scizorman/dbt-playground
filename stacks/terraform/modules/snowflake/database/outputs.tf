output "name" {
  description = "The database name."
  value       = snowflake_database.this.name
}

output "reader_database_role_name" {
  description = "The database role that has read-only access to the database."
  value       = "\"${snowflake_database.this.name}\".\"${snowflake_database_role.this_reader.name}\""
}

output "writer_database_role_name" {
  description = "The database role that has read-write access to the database."
  value       = "\"${snowflake_database.this.name}\".\"${snowflake_database_role.this_writer.name}\""
}
