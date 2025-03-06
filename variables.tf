variable "alias" {
  type = list(object({
    id = any
    function_id    = any
    function_version = string
    name             = string
    description = optional(string)
    routing_config = optional(list(object({
      additional_version_weights = optional(map(string))
    })), [])
  }))
  default = []
  description = <<EOT
EOT

  validation {
    condition = length([for a in var.alias : true if can(regex("($LATEST|[0-9]+)", var.alias.function_version))]) == length(var.alias)
    error_message = "Lambda function version for which you are creating the alias. Pattern: ($LATEST|[0-9]+)."
  }

  validation {
    condition = length([for b in var.alias : true if can(regex("(?!^[0-9]+$)([a-zA-Z0-9-_]+)", var.alias.name))]) == length(var.alias)
    error_message = "Name for the alias you are creating. Pattern: (?!^[0-9]+$)([a-zA-Z0-9-_]+)."
  }
}

variable "code_signing_config" {
  type = list(object({
    id = any
    description = optional(string)
    tags = optional(map(string))
    allowed_publishers = optional(list(object({
      signing_profile_version_arns = list(string)
    })), [])
    policies = optional(list(object({
      untrusted_artifact_on_deployment = string
    })), [])
  }))
  default = []
  description = <<EOT
Provides a Lambda Code Signing Config resource. A code signing configuration defines a list of allowed signing profiles and defines the code-signing validation policy (action to be taken if deployment validation checks fail).
EOT

  validation {
    condition = length([for a in var.code_signing_config : true if contains(["Warn", "Enforce"], var.code_signing_config.policies.untrusted_artifact_on_deployment)]) == length(var.code_signing_config)
    error_message = "Valid values : Warn or Enforce."
  }
}

variable "event_source_mapping" {
  type = list(object({
    id = any
    function_id = any
    batch_size = optional(number)
    bisect_batch_on_function_error = optional(bool)
    enabled = optional(bool)
    event_source_arn = optional(string)
    function_response_types = []
    kms_key_arn = optional(string)
    maximum_batching_window_in_seconds = optional(number)
    maximum_record_age_in_seconds = optional(number)
    maximum_retry_attempts = optional(number)
    parallelization_factor = optional(number)
    queues = optional(list(string))
    starting_position = optional(string)
    starting_position_timestamp = optional(string)
    tags = optional(map(string))
    topics = optional(list(string))
    tumbling_window_in_seconds = optional(number)
    amazon_managed_kafka_event_source_config = optional(list(object({
      consumer_group_id = optional(any)
    })), [])
    destination_config = optional(list(object({
      on_failure = optional(list(object({
        destination_arn = optional(any)
      })), [])
    })), [])
    document_db_event_source_config = optional(list(object({
      database_name = string
      collection_name = optional(string)
      full_document = optional(string)
    })), [])
    filter_criteria = optional(list(object({
      filter = optional(list(object({
        pattern = string
      })))
    })), [])
    metrics_config = optional(list(object({
      metrics = optional(list(string))
    })), [])
    provisioned_poller_config = optional(list(object({
      maximum_pollers = optional(number)
      minimum_pollers = optional(number)
    })), [])
    scaling_config = optional(list(object({
      maximum_concurrency = optional(number)
    })), [])
    self_managed_event_source = optional(list(object({
      endpoints = map(string)
    })), [])
    self_managed_kafka_event_source_config = optional(list(object({
      consumer_group_id = optional(any)
    })), [])
    source_access_configuration = optional(list(object({
      type = string
      uri = string
    })), [])
  }))
  default = []
  description = <<EOT
EOT
}

variable "function" {
  type = list(object({
    id = any
    function_name = string
    role_id          = any
  }))
  default = []
  description = <<EOT
EOT
}

variable "function_event_invoke_config" {
  type = list(object({
    id = any
    function_id = any
  }))
  default = []
  description = <<EOT
EOT
}

variable "function_recursion_config" {
  type = list(object({
    id = any
    function_id  = any
    recursive_loop = string
  }))
  default = []
  description = <<EOT
EOT
}

variable "function_url" {
  type = list(object({
    id = any
    authorization_type = string
    function_id      = any
  }))
  default = []
  description = <<EOT
EOT
}

variable "invocation" {
  type = list(object({
    id = any
    function_id = any
    input         = string
  }))
  default = []
  description = <<EOT
EOT
}

variable "layer_version" {
  type = list(object({
    id = any
    layer_name = string
  }))
  default = []
  description = <<EOT
EOT
}

variable "layer_version_permission" {
  type = list(object({
    id = any
    action         = string
    layer_id     = any
    principal      = string
    statement_id   = string
    version_number = number
  }))
  default = []
  description = <<EOT
EOT
}

variable "permission" {
  type = list(object({
    id = any
    action        = string
    function_id = any
    principal     = string
  }))
  default = []
  description = <<EOT
EOT
}

variable "provisioned_concurrency_config" {
  type = list(object({
    id = any
    function_id                     = any
    provisioned_concurrent_executions = number
    qualifier                         = string
  }))
  default = []
  description = <<EOT
EOT
}

variable "runtime_management_config" {
  type = list(object({
    id = any
    function_id = any
  }))
  default = []
  description = <<EOT
EOT
}
