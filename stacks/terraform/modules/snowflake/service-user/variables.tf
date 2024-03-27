variable "environment" {
  description = "Specifies the environment of a service user."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[A-Z]+$", var.environment))
    error_message = "The variable 'environment' must be in uppercase."
  }
}

variable "project" {
  description = "Specifies the project of a service user."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[A-Z_]+$", var.project))
    error_message = "The variable 'project' must be in uppercase."
  }
}

variable "business_function" {
  description = "Specifies the business function of a service user."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[A-Z_]+$", var.business_function))
    error_message = "The variable 'business_function' must be in uppercase."
  }
}

variable "comment" {
  description = "Specifies the comment for a user."
  type        = string
  nullable    = false
}

variable "granted_role_name" {
  description = "Specifies the role name which will be granted to the user."
  type        = string
  nullable    = false
}

variable "default_role" {
  description = "Specifies the default role for a user."
  type        = string
  default     = null
}

variable "default_warehouse" {
  description = "Specifies the default warehouse for a user."
  type        = string
  default     = null
}
