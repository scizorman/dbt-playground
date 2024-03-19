output "name" {
  description = "The warehouse name."
  value       = snowflake_warehouse.this.name
}

output "usage_role_name" {
  description = "The role name that has USAGE privilege on the warehouse."
  value       = snowflake_role.this_usage.name
}
