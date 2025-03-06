output "alias_id" {
  value = try(aws_lambda_alias.alias.*.id)
}

output "alias_arn" {
  value = try(aws_lambda_alias.alias.*.arn)
}

output "alias_name" {
  value = try(aws_lambda_alias.alias.*.name)
}

output "recursion_config_id" {
  value = try(aws_lambda_function_recursion_config.function_recursion_config.*.id)
}

