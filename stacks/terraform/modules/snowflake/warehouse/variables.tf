variable "environment" {
  description = "Specifies the environment in which a warehouse is used."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[A-Z]+$", var.environment))
    error_message = "The variable 'environment' must be in uppercase."
  }
}

variable "project" {
  description = "Specifies the project in which a warehouse is used."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[A-Z_]+$", var.project))
    error_message = "The variable 'project' must be in uppercase."
  }
}

variable "business_function" {
  description = "Specifies the business function of a warehouse."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[A-Z_]+$", var.business_function))
    error_message = "The variable 'business_function' must be in uppercase."
  }
}

variable "comment" {
  description = "Specifies the comment for a warehouse."
  type        = string
  nullable    = false
}

variable "auto_suspend_seconds" {
  description = "Specifies the number of seconds of inactivity after which a warehouse is automatically suspended."
  type        = number
  default     = 60
}

variable "statement_queued_timeout_in_seconds" {
  description = "Specifies the number of seconds that a SQL statement can be queued on a warehouse before it is canceled by the system."
  type        = number
  default     = 0
}

variable "statement_timeout_in_seconds" {
  description = "A number of days for which Snowflake retains historical data for performing Time Travel actions (SELECT, CLONE, UNDROP) on the database."
  type        = number
  default     = 300
}

variable "warehouse_size" {
  description = "Specifies the size (XSMALL - 6XLARGE) of the virtual warehouse."
  type        = string
  default     = "XSMALL"
}

variable "warehouse_type" {
  description = "Specifies a STANDARD or SNOWPARK-OPTIMIZED warehouse."
  type        = string
  default     = "STANDARD"
}
