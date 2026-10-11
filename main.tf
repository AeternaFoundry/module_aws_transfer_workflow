resource "aws_transfer_workflow" "transfer_workflows" {
  for_each = var.transfer_workflows

  description = each.value.description
  region      = each.value.region
  tags        = each.value.tags
  tags_all    = each.value.tags_all

  dynamic "steps" {
    for_each = each.value.steps
    content {
      dynamic "copy_step_details" {
        for_each = steps.value.copy_step_details != null ? [steps.value.copy_step_details] : []
        content {
          dynamic "destination_file_location" {
            for_each = copy_step_details.value.destination_file_location != null ? [copy_step_details.value.destination_file_location] : []
            content {
              dynamic "efs_file_location" {
                for_each = destination_file_location.value.efs_file_location != null ? [destination_file_location.value.efs_file_location] : []
                content {
                  file_system_id = efs_file_location.value.file_system_id
                  path           = efs_file_location.value.path
                }
              }
              dynamic "s3_file_location" {
                for_each = destination_file_location.value.s3_file_location != null ? [destination_file_location.value.s3_file_location] : []
                content {
                  bucket = s3_file_location.value.bucket
                  key    = s3_file_location.value.key
                }
              }
            }
          }
          name                 = copy_step_details.value.name
          overwrite_existing   = copy_step_details.value.overwrite_existing
          source_file_location = copy_step_details.value.source_file_location
        }
      }
      dynamic "custom_step_details" {
        for_each = steps.value.custom_step_details != null ? [steps.value.custom_step_details] : []
        content {
          name                 = custom_step_details.value.name
          source_file_location = custom_step_details.value.source_file_location
          target               = custom_step_details.value.target
          timeout_seconds      = custom_step_details.value.timeout_seconds
        }
      }
      dynamic "decrypt_step_details" {
        for_each = steps.value.decrypt_step_details != null ? [steps.value.decrypt_step_details] : []
        content {
          dynamic "destination_file_location" {
            for_each = decrypt_step_details.value.destination_file_location != null ? [decrypt_step_details.value.destination_file_location] : []
            content {
              dynamic "efs_file_location" {
                for_each = destination_file_location.value.efs_file_location != null ? [destination_file_location.value.efs_file_location] : []
                content {
                  file_system_id = efs_file_location.value.file_system_id
                  path           = efs_file_location.value.path
                }
              }
              dynamic "s3_file_location" {
                for_each = destination_file_location.value.s3_file_location != null ? [destination_file_location.value.s3_file_location] : []
                content {
                  bucket = s3_file_location.value.bucket
                  key    = s3_file_location.value.key
                }
              }
            }
          }
          name                 = decrypt_step_details.value.name
          overwrite_existing   = decrypt_step_details.value.overwrite_existing
          source_file_location = decrypt_step_details.value.source_file_location
          type                 = decrypt_step_details.value.type
        }
      }
      dynamic "delete_step_details" {
        for_each = steps.value.delete_step_details != null ? [steps.value.delete_step_details] : []
        content {
          name                 = delete_step_details.value.name
          source_file_location = delete_step_details.value.source_file_location
        }
      }
      dynamic "tag_step_details" {
        for_each = steps.value.tag_step_details != null ? [steps.value.tag_step_details] : []
        content {
          name                 = tag_step_details.value.name
          source_file_location = tag_step_details.value.source_file_location
          dynamic "tags" {
            for_each = tag_step_details.value.tags != null ? tag_step_details.value.tags : []
            content {
              key   = tags.value.key
              value = tags.value.value
            }
          }
        }
      }
      type = steps.value.type
    }
  }

  dynamic "on_exception_steps" {
    for_each = each.value.on_exception_steps != null ? each.value.on_exception_steps : []
    content {
      dynamic "copy_step_details" {
        for_each = on_exception_steps.value.copy_step_details != null ? [on_exception_steps.value.copy_step_details] : []
        content {
          dynamic "destination_file_location" {
            for_each = copy_step_details.value.destination_file_location != null ? [copy_step_details.value.destination_file_location] : []
            content {
              dynamic "efs_file_location" {
                for_each = destination_file_location.value.efs_file_location != null ? [destination_file_location.value.efs_file_location] : []
                content {
                  file_system_id = efs_file_location.value.file_system_id
                  path           = efs_file_location.value.path
                }
              }
              dynamic "s3_file_location" {
                for_each = destination_file_location.value.s3_file_location != null ? [destination_file_location.value.s3_file_location] : []
                content {
                  bucket = s3_file_location.value.bucket
                  key    = s3_file_location.value.key
                }
              }
            }
          }
          name                 = copy_step_details.value.name
          overwrite_existing   = copy_step_details.value.overwrite_existing
          source_file_location = copy_step_details.value.source_file_location
        }
      }
      dynamic "custom_step_details" {
        for_each = on_exception_steps.value.custom_step_details != null ? [on_exception_steps.value.custom_step_details] : []
        content {
          name                 = custom_step_details.value.name
          source_file_location = custom_step_details.value.source_file_location
          target               = custom_step_details.value.target
          timeout_seconds      = custom_step_details.value.timeout_seconds
        }
      }
      dynamic "decrypt_step_details" {
        for_each = on_exception_steps.value.decrypt_step_details != null ? [on_exception_steps.value.decrypt_step_details] : []
        content {
          dynamic "destination_file_location" {
            for_each = decrypt_step_details.value.destination_file_location != null ? [decrypt_step_details.value.destination_file_location] : []
            content {
              dynamic "efs_file_location" {
                for_each = destination_file_location.value.efs_file_location != null ? [destination_file_location.value.efs_file_location] : []
                content {
                  file_system_id = efs_file_location.value.file_system_id
                  path           = efs_file_location.value.path
                }
              }
              dynamic "s3_file_location" {
                for_each = destination_file_location.value.s3_file_location != null ? [destination_file_location.value.s3_file_location] : []
                content {
                  bucket = s3_file_location.value.bucket
                  key    = s3_file_location.value.key
                }
              }
            }
          }
          name                 = decrypt_step_details.value.name
          overwrite_existing   = decrypt_step_details.value.overwrite_existing
          source_file_location = decrypt_step_details.value.source_file_location
          type                 = decrypt_step_details.value.type
        }
      }
      dynamic "delete_step_details" {
        for_each = on_exception_steps.value.delete_step_details != null ? [on_exception_steps.value.delete_step_details] : []
        content {
          name                 = delete_step_details.value.name
          source_file_location = delete_step_details.value.source_file_location
        }
      }
      dynamic "tag_step_details" {
        for_each = on_exception_steps.value.tag_step_details != null ? [on_exception_steps.value.tag_step_details] : []
        content {
          name                 = tag_step_details.value.name
          source_file_location = tag_step_details.value.source_file_location
          dynamic "tags" {
            for_each = tag_step_details.value.tags != null ? tag_step_details.value.tags : []
            content {
              key   = tags.value.key
              value = tags.value.value
            }
          }
        }
      }
      type = on_exception_steps.value.type
    }
  }
}

