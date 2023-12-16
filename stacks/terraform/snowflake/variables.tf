variable "snowflake_private_key_path" {
  description = "The path to a private key for using keypair authentication with Snowflake."
  type        = string
  nullable    = false
}

variable "snowflake_private_key_passphrase" {
  description = "The passphrase for the private key for using keypair authentication with Snowflake."
  type        = string
  nullable    = false
  sensitive   = true
}
