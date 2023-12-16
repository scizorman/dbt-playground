variable "snowflake_private_key_path" {
  description = "snowflake_private"
  type        = string
  nullable    = false
}

variable "snowflake_private_key_passphrase" {
  description = ""
  type        = string
  nullable    = false
  sensitive   = true
}
