variable "environment" {
  description = "Specifies the environment in which a functional role is used."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[A-Z]+$", var.environment))
    error_message = "The variable 'environment' must be in uppercase."
  }
}

variable "project" {
  description = "Specifies the project in which a functional role is used."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[A-Z_]+$", var.project))
    error_message = "The variable 'project' must be in uppercase."
  }
}

variable "business_function" {
  description = "Specifies the business function of a functional role."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[A-Z_]+$", var.business_function))
    error_message = "The variable 'business_function' must be in uppercase."
  }
}

variable "comment" {
  description = "Specifies the comment for a functional role."
  type        = string
  nullable    = false
}

variable "access_roles" {
  description = "Specifies access roles to be granted to a functional role."
  type        = list(string)
  nullable    = false

  validation {
    condition     = length(var.access_roles) > 0
    error_message = "The variable 'access_roles' must be specified at least one access role."
  }
}

variable "database_roles" {
  description = "Specifies database roles to be granted to a functional role."
  type        = list(string)
  default     = []
}
