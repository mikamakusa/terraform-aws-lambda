resource "aws_lambda_alias" "alias" {
  count = length(var.alias)
  function_name    = element(aws_lambda_function.function.*.arn, lookup(var.alias[count.index], "function_id"))
  function_version = lookup(var.alias[count.index], "function_version")
  name             = lookup(var.alias[count.index], "name")
  description = lookup(var.alias[count.index], "description")

  dynamic "routing_config" {
    for_each = try(lookup(var.alias[count.index], "routing_config") == null ? [] : ["routing_config"])
    content {
      additional_version_weights = lookup(routing_config.value, "additional_version_weights")
    }
  }
}

resource "aws_lambda_code_signing_config" "code_signing_config" {
  count = length(var.code_signing_config)
  description = lookup(var.code_signing_config[count.index], "description")
  tags = lookup(var.code_signing_config[count.index], "tags")

  dynamic "allowed_publishers" {
    for_each = try(lookup(var.code_signing_config[count.index], "allowed_publishers") == null ? [] : ["allowed_publishers"])
    content {
      signing_profile_version_arns = lookup(allowed_publishers.value, "signing_profile_version_arns")
    }
  }

  dynamic "policies" {
    for_each = try(lookup(var.code_signing_config[count.index], "policies") == null ? [] : ["policies"])
    content {
      untrusted_artifact_on_deployment = lookup(policies.value, "untrusted_artifact_on_deployment")
    }
  }
}

resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  count = length(var.event_source_mapping)
  function_name = element(aws_lambda_function.function.*.arn, lookup(var.event_source_mapping[count.index], "function_id"))
  batch_size = lookup(var.event_source_mapping[count.index], "batch_size")
  bisect_batch_on_function_error = lookup(var.event_source_mapping[count.index], "bisect_batch_on_function_error")
  enabled = lookup(var.event_source_mapping[count.index], "enabled")
  event_source_arn = ""
  function_response_types = ["ReportBatchItemFailures"]
  kms_key_arn = ""
  maximum_batching_window_in_seconds = lookup(var.event_source_mapping[count.index], "maximum_batching_window_in_seconds")
  maximum_record_age_in_seconds = lookup(var.event_source_mapping[count.index], "maximum_record_age_in_seconds")
  maximum_retry_attempts = lookup(var.event_source_mapping[count.index], "maximum_retry_attempts")
  parallelization_factor = lookup(var.event_source_mapping[count.index], "parallelization_factor")
  queues = lookup(var.event_source_mapping[count.index], "queues")
  starting_position = lookup(var.event_source_mapping[count.index], "starting_position")
  starting_position_timestamp = lookup(var.event_source_mapping[count.index], "starting_position_timestamp")
  tags = {}
  topics = lookup(var.event_source_mapping[count.index], "topics")
  tumbling_window_in_seconds = lookup(var.event_source_mapping[count.index], "tumbling_window_in_seconds")

  dynamic "amazon_managed_kafka_event_source_config" {
    for_each = try(lookup(var.event_source_mapping[count.index], "amazon_managed_kafka_event_source_config") == null ? [] : ["amazon_managed_kafka_event_source_config"])
    content {
      consumer_group_id = ""
    }
  }

  dynamic "destination_config" {
    for_each = try(lookup(var.event_source_mapping[count.index], "destination_config") == null ? [] : ["destination_config"])
    content {
      dynamic "on_failure" {
        for_each = ""
        content {
          destination_arn = ""
        }
      }
    }
  }

  dynamic "document_db_event_source_config" {
    for_each = try(lookup(var.event_source_mapping[count.index], "document_db_event_source_config") == null ? [] : ["document_db_event_source_config"])
    content {
      database_name = ""
      collection_name = ""
      full_document = ""
    }
  }

  dynamic "filter_criteria" {
    for_each = try(lookup(var.event_source_mapping[count.index], "filter_criteria") == null ? [] : ["filter_criteria"])
    content {
      dynamic "filter" {
        for_each = ""
        content {
          pattern = ""
        }
      }
    }
  }

  dynamic "metrics_config" {
    for_each = try(lookup(var.event_source_mapping[count.index], "metrics_config") == null ? [] : ["metrics_config"])
    content {
      metrics = []
    }
  }

  dynamic "provisioned_poller_config" {
    for_each = try(lookup(var.event_source_mapping[count.index], "provisioned_poller_config") == null ? [] : ["provisioned_poller_config"])
    content {
      maximum_pollers = 0
      minimum_pollers = 0
    }
  }

  dynamic "scaling_config" {
    for_each = try(lookup(var.event_source_mapping[count.index], "scaling_config") == null ? [] : ["scaling_config"])
    content {
      maximum_concurrency = 0
    }
  }

  dynamic "self_managed_event_source" {
    for_each = try(lookup(var.event_source_mapping[count.index], "self_managed_event_source") == null ? [] : ["self_managed_event_source"])
    content {
      endpoints = {}
    }
  }

  dynamic "self_managed_kafka_event_source_config" {
    for_each = try(lookup(var.event_source_mapping[count.index], "self_managed_kafka_event_source_config") == null ? [] : ["self_managed_kafka_event_source_config"])
    content {
      consumer_group_id = ""
    }
  }

  dynamic "source_access_configuration" {
    for_each = ""
    content {
      type = ""
      uri  = ""
    }
  }
}

resource "aws_lambda_function" "function" {
  count = length(var.function)
  function_name = lookup(var.function[count.index], "function_name")
  role          = ""
}

resource "aws_lambda_function_event_invoke_config" "function_event_invoke_config" {
  count = length(var.function_event_invoke_config)
  function_name = element(aws_lambda_function.function.*.function_name, lookup(var.function_event_invoke_config[count.index], "function_id"))
}

resource "aws_lambda_function_recursion_config" "function_recursion_config" {
  count = length(var.function_recursion_config)
  function_name  = element(aws_lambda_function.function.*.function_name, lookup(var.function_recursion_config[count.index], "function_id"))
  recursive_loop = lookup(var.function_recursion_config[count.index], "recursive_loop")
}

resource "aws_lambda_function_url" "function_url" {
  count = length(var.function_url)
  authorization_type = lookup(var.function_url[count.index], "authorization_type")
  function_name      = element(aws_lambda_function.function.*.function_name, lookup(var.function_url[count.index], "function_id"))
}

resource "aws_lambda_invocation" "invocation" {
  count = length(var.invocation)
  function_name = element(aws_lambda_function.function.*.function_name, lookup(var.invocation[count.index], "function_id"))
  input         = lookup(var.invocation[count.index], "input")
}

resource "aws_lambda_layer_version" "layer_version" {
  count = length(var.layer_version)
  layer_name = lookup(var.layer_version[count.index], "layer_name")
}

resource "aws_lambda_layer_version_permission" "layer_version_permission" {
  count = length(var.layer_version_permission)
  action         = lookup(var.layer_version_permission[count.index], "action")
  layer_name     = element(aws_lambda_layer_version.layer_version.*.arn, lookup(var.layer_version_permission[count.index], "layer_name"))
  principal      = lookup(var.layer_version_permission[count.index], "principal")
  statement_id   = lookup(var.layer_version_permission[count.index], "statement_id")
  version_number = lookup(var.layer_version_permission[count.index], "version_number")
}

resource "aws_lambda_permission" "permission" {
  count = length(var.permission)
  action        = lookup(var.permission[count.index], "action")
  function_name = element(aws_lambda_function.function.*.function_name, lookup(var.permission[count.index], "function_id"))
  principal     = lookup(var.permission[count.index], "principal")
}

resource "aws_lambda_provisioned_concurrency_config" "provisioned_concurrency_config" {
  count = length(var.provisioned_concurrency_config)
  function_name                     = element(aws_lambda_function.function.*.function_name, lookup(var.provisioned_concurrency_config[count.index], "function_id"))
  provisioned_concurrent_executions = lookup(var.provisioned_concurrency_config[count.index], "provisioned_concurrent_executions")
  qualifier                         = lookup(var.provisioned_concurrency_config[count.index], "qualifier")
}

resource "aws_lambda_runtime_management_config" "runtime_management_config" {
  count = length(var.runtime_management_config)
  function_name = element(aws_lambda_function.function.*.function_name, lookup(var.runtime_management_config[count.index], "function_id"))
}