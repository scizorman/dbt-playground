variable "environment" {
  description = "Specifies the environment in which a database is used."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[A-Z]+$", var.environment))
    error_message = "The variable 'environment' must be in uppercase."
  }
}

variable "project" {
  description = "Specifies the project in which a database is used."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[A-Z_]+$", var.project))
    error_message = "The variable 'project' must be in uppercase."
  }
}

variable "data_layer" {
  description = "Specifies the data layer of a database."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[A-Z_]+$", var.data_layer))
    error_message = "The variable 'data_layer' must be in uppercase."
  }
}

variable "comment" {
  description = "Specifies the comment for a database."
  type        = string
  nullable    = false
}

variable "data_retention_time_in_days" {
  description = "Specifies the number of days for which Snowflake retains historical data for performing Time Travel actions (SELECT, CLONE, UNDROP) on a database."
  type        = number
  default     = null
}

variable "is_transient" {
  description = "Specifies a database as transient."
  type        = bool
  default     = null
}
