output "transfer_workflows_id" {
  description = "Map of id values across all transfer_workflows, keyed the same as var.transfer_workflows"
  value       = { for k, v in aws_transfer_workflow.transfer_workflows : k => v.id if v.id != null && length(v.id) > 0 }
}
output "transfer_workflows_arn" {
  description = "Map of arn values across all transfer_workflows, keyed the same as var.transfer_workflows"
  value       = { for k, v in aws_transfer_workflow.transfer_workflows : k => v.arn if v.arn != null && length(v.arn) > 0 }
}
output "transfer_workflows_description" {
  description = "Map of description values across all transfer_workflows, keyed the same as var.transfer_workflows"
  value       = { for k, v in aws_transfer_workflow.transfer_workflows : k => v.description if v.description != null && length(v.description) > 0 }
}
output "transfer_workflows_on_exception_steps" {
  description = "Map of on_exception_steps values across all transfer_workflows, keyed the same as var.transfer_workflows"
  value       = { for k, v in aws_transfer_workflow.transfer_workflows : k => v.on_exception_steps if v.on_exception_steps != null && length(v.on_exception_steps) > 0 }
}
output "transfer_workflows_region" {
  description = "Map of region values across all transfer_workflows, keyed the same as var.transfer_workflows"
  value       = { for k, v in aws_transfer_workflow.transfer_workflows : k => v.region if v.region != null && length(v.region) > 0 }
}
output "transfer_workflows_steps" {
  description = "Map of steps values across all transfer_workflows, keyed the same as var.transfer_workflows"
  value       = { for k, v in aws_transfer_workflow.transfer_workflows : k => v.steps if v.steps != null && length(v.steps) > 0 }
}
output "transfer_workflows_tags" {
  description = "Map of tags values across all transfer_workflows, keyed the same as var.transfer_workflows"
  value       = { for k, v in aws_transfer_workflow.transfer_workflows : k => v.tags if v.tags != null && length(v.tags) > 0 }
}
output "transfer_workflows_tags_all" {
  description = "Map of tags_all values across all transfer_workflows, keyed the same as var.transfer_workflows"
  value       = { for k, v in aws_transfer_workflow.transfer_workflows : k => v.tags_all if v.tags_all != null && length(v.tags_all) > 0 }
}

