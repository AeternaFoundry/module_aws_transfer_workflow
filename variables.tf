variable "transfer_workflows" {
  description = <<EOT
Map of transfer_workflows, attributes below
Required:
    - steps (block):
        - copy_step_details (optional, block):
            - destination_file_location (optional, block):
                - efs_file_location (optional, block):
                    - file_system_id (optional)
                    - path (optional)
                - s3_file_location (optional, block):
                    - bucket (optional)
                    - key (optional)
            - name (optional)
            - overwrite_existing (optional)
            - source_file_location (optional)
        - custom_step_details (optional, block):
            - name (optional)
            - source_file_location (optional)
            - target (optional)
            - timeout_seconds (optional)
        - decrypt_step_details (optional, block):
            - destination_file_location (optional, block):
                - efs_file_location (optional, block):
                    - file_system_id (optional)
                    - path (optional)
                - s3_file_location (optional, block):
                    - bucket (optional)
                    - key (optional)
            - name (optional)
            - overwrite_existing (optional)
            - source_file_location (optional)
            - type (required)
        - delete_step_details (optional, block):
            - name (optional)
            - source_file_location (optional)
        - tag_step_details (optional, block):
            - name (optional)
            - source_file_location (optional)
            - tags (optional, block):
                - key (required)
                - value (required)
        - type (required)
Optional:
    - description
    - region
    - tags
    - tags_all
    - on_exception_steps (block):
        - copy_step_details (optional, block):
            - destination_file_location (optional, block):
                - efs_file_location (optional, block):
                    - file_system_id (optional)
                    - path (optional)
                - s3_file_location (optional, block):
                    - bucket (optional)
                    - key (optional)
            - name (optional)
            - overwrite_existing (optional)
            - source_file_location (optional)
        - custom_step_details (optional, block):
            - name (optional)
            - source_file_location (optional)
            - target (optional)
            - timeout_seconds (optional)
        - decrypt_step_details (optional, block):
            - destination_file_location (optional, block):
                - efs_file_location (optional, block):
                    - file_system_id (optional)
                    - path (optional)
                - s3_file_location (optional, block):
                    - bucket (optional)
                    - key (optional)
            - name (optional)
            - overwrite_existing (optional)
            - source_file_location (optional)
            - type (required)
        - delete_step_details (optional, block):
            - name (optional)
            - source_file_location (optional)
        - tag_step_details (optional, block):
            - name (optional)
            - source_file_location (optional)
            - tags (optional, block):
                - key (required)
                - value (required)
        - type (required)
EOT

  type = map(object({
    description = optional(string)
    region      = optional(string)
    tags        = optional(map(string))
    tags_all    = optional(map(string))
    steps = list(object({
      copy_step_details = optional(object({
        destination_file_location = optional(object({
          efs_file_location = optional(object({
            file_system_id = optional(string)
            path           = optional(string)
          }))
          s3_file_location = optional(object({
            bucket = optional(string)
            key    = optional(string)
          }))
        }))
        name                 = optional(string)
        overwrite_existing   = optional(string)
        source_file_location = optional(string)
      }))
      custom_step_details = optional(object({
        name                 = optional(string)
        source_file_location = optional(string)
        target               = optional(string)
        timeout_seconds      = optional(number)
      }))
      decrypt_step_details = optional(object({
        destination_file_location = optional(object({
          efs_file_location = optional(object({
            file_system_id = optional(string)
            path           = optional(string)
          }))
          s3_file_location = optional(object({
            bucket = optional(string)
            key    = optional(string)
          }))
        }))
        name                 = optional(string)
        overwrite_existing   = optional(string)
        source_file_location = optional(string)
        type                 = string
      }))
      delete_step_details = optional(object({
        name                 = optional(string)
        source_file_location = optional(string)
      }))
      tag_step_details = optional(object({
        name                 = optional(string)
        source_file_location = optional(string)
        tags = optional(list(object({
          key   = string
          value = string
        })))
      }))
      type = string
    }))
    on_exception_steps = optional(list(object({
      copy_step_details = optional(object({
        destination_file_location = optional(object({
          efs_file_location = optional(object({
            file_system_id = optional(string)
            path           = optional(string)
          }))
          s3_file_location = optional(object({
            bucket = optional(string)
            key    = optional(string)
          }))
        }))
        name                 = optional(string)
        overwrite_existing   = optional(string)
        source_file_location = optional(string)
      }))
      custom_step_details = optional(object({
        name                 = optional(string)
        source_file_location = optional(string)
        target               = optional(string)
        timeout_seconds      = optional(number)
      }))
      decrypt_step_details = optional(object({
        destination_file_location = optional(object({
          efs_file_location = optional(object({
            file_system_id = optional(string)
            path           = optional(string)
          }))
          s3_file_location = optional(object({
            bucket = optional(string)
            key    = optional(string)
          }))
        }))
        name                 = optional(string)
        overwrite_existing   = optional(string)
        source_file_location = optional(string)
        type                 = string
      }))
      delete_step_details = optional(object({
        name                 = optional(string)
        source_file_location = optional(string)
      }))
      tag_step_details = optional(object({
        name                 = optional(string)
        source_file_location = optional(string)
        tags = optional(list(object({
          key   = string
          value = string
        })))
      }))
      type = string
    })))
  }))
  validation {
    condition = alltrue([
      for k, v in var.transfer_workflows : (
        length(v.steps) >= 1 && length(v.steps) <= 8
      )
    ])
    error_message = "Each steps list must contain between 1 and 8 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.transfer_workflows : (
        alltrue([for item in v.steps : (item.tag_step_details == null || (item.tag_step_details.tags == null || (length(item.tag_step_details.tags) <= 10)))])
      )
    ])
    error_message = "Each tags list must contain at most 10 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.transfer_workflows : (
        v.on_exception_steps == null || (length(v.on_exception_steps) <= 8)
      )
    ])
    error_message = "Each on_exception_steps list must contain at most 8 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.transfer_workflows : (
        v.on_exception_steps == null || alltrue([for item in v.on_exception_steps : (item.tag_step_details == null || (item.tag_step_details.tags == null || (length(item.tag_step_details.tags) <= 10)))])
      )
    ])
    error_message = "Each tags list must contain at most 10 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.transfer_workflows : (
        v.on_exception_steps == null || alltrue([for item in v.on_exception_steps : (item.copy_step_details == null || (item.copy_step_details.source_file_location == null || ((length(item.copy_step_details.source_file_location) >= 0 && length(item.copy_step_details.source_file_location) <= 256) && (can(regex("^\\$\\{(\\w+.)+\\w+\\}$", item.copy_step_details.source_file_location))))))])
      )
    ])
    error_message = "all of: must be between 0 and 256 characters; Must be of the pattern ^\\$\\{(\\w+.)+\\w+\\}$"
  }
  validation {
    condition = alltrue([
      for k, v in var.transfer_workflows : (
        v.on_exception_steps == null || alltrue([for item in v.on_exception_steps : (item.custom_step_details == null || (item.custom_step_details.source_file_location == null || ((length(item.custom_step_details.source_file_location) >= 0 && length(item.custom_step_details.source_file_location) <= 256) && (can(regex("^\\$\\{(\\w+.)+\\w+\\}$", item.custom_step_details.source_file_location))))))])
      )
    ])
    error_message = "all of: must be between 0 and 256 characters; Must be of the pattern ^\\$\\{(\\w+.)+\\w+\\}$"
  }
  validation {
    condition = alltrue([
      for k, v in var.transfer_workflows : (
        v.on_exception_steps == null || alltrue([for item in v.on_exception_steps : (item.custom_step_details == null || (item.custom_step_details.timeout_seconds == null || (item.custom_step_details.timeout_seconds >= 1 && item.custom_step_details.timeout_seconds <= 1800)))])
      )
    ])
    error_message = "must be between 1 and 1800"
  }
  validation {
    condition = alltrue([
      for k, v in var.transfer_workflows : (
        v.on_exception_steps == null || alltrue([for item in v.on_exception_steps : (item.decrypt_step_details == null || (item.decrypt_step_details.source_file_location == null || ((length(item.decrypt_step_details.source_file_location) >= 0 && length(item.decrypt_step_details.source_file_location) <= 256) && (can(regex("^\\$\\{(\\w+.)+\\w+\\}$", item.decrypt_step_details.source_file_location))))))])
      )
    ])
    error_message = "all of: must be between 0 and 256 characters; Must be of the pattern ^\\$\\{(\\w+.)+\\w+\\}$"
  }
  validation {
    condition = alltrue([
      for k, v in var.transfer_workflows : (
        v.on_exception_steps == null || alltrue([for item in v.on_exception_steps : (item.delete_step_details == null || (item.delete_step_details.source_file_location == null || ((length(item.delete_step_details.source_file_location) >= 0 && length(item.delete_step_details.source_file_location) <= 256) && (can(regex("^\\$\\{(\\w+.)+\\w+\\}$", item.delete_step_details.source_file_location))))))])
      )
    ])
    error_message = "all of: must be between 0 and 256 characters; Must be of the pattern ^\\$\\{(\\w+.)+\\w+\\}$"
  }
  validation {
    condition = alltrue([
      for k, v in var.transfer_workflows : (
        v.on_exception_steps == null || alltrue([for item in v.on_exception_steps : (item.tag_step_details == null || (item.tag_step_details.source_file_location == null || ((length(item.tag_step_details.source_file_location) >= 0 && length(item.tag_step_details.source_file_location) <= 256) && (can(regex("^\\$\\{(\\w+.)+\\w+\\}$", item.tag_step_details.source_file_location))))))])
      )
    ])
    error_message = "all of: must be between 0 and 256 characters; Must be of the pattern ^\\$\\{(\\w+.)+\\w+\\}$"
  }
  validation {
    condition = alltrue([
      for k, v in var.transfer_workflows : (
        alltrue([for item in v.steps : (item.copy_step_details == null || (item.copy_step_details.source_file_location == null || ((length(item.copy_step_details.source_file_location) >= 0 && length(item.copy_step_details.source_file_location) <= 256) && (can(regex("^\\$\\{(\\w+.)+\\w+\\}$", item.copy_step_details.source_file_location))))))])
      )
    ])
    error_message = "all of: must be between 0 and 256 characters; Must be of the pattern ^\\$\\{(\\w+.)+\\w+\\}$"
  }
  validation {
    condition = alltrue([
      for k, v in var.transfer_workflows : (
        alltrue([for item in v.steps : (item.custom_step_details == null || (item.custom_step_details.source_file_location == null || ((length(item.custom_step_details.source_file_location) >= 0 && length(item.custom_step_details.source_file_location) <= 256) && (can(regex("^\\$\\{(\\w+.)+\\w+\\}$", item.custom_step_details.source_file_location))))))])
      )
    ])
    error_message = "all of: must be between 0 and 256 characters; Must be of the pattern ^\\$\\{(\\w+.)+\\w+\\}$"
  }
  validation {
    condition = alltrue([
      for k, v in var.transfer_workflows : (
        alltrue([for item in v.steps : (item.custom_step_details == null || (item.custom_step_details.timeout_seconds == null || (item.custom_step_details.timeout_seconds >= 1 && item.custom_step_details.timeout_seconds <= 1800)))])
      )
    ])
    error_message = "must be between 1 and 1800"
  }
  validation {
    condition = alltrue([
      for k, v in var.transfer_workflows : (
        alltrue([for item in v.steps : (item.decrypt_step_details == null || (item.decrypt_step_details.source_file_location == null || ((length(item.decrypt_step_details.source_file_location) >= 0 && length(item.decrypt_step_details.source_file_location) <= 256) && (can(regex("^\\$\\{(\\w+.)+\\w+\\}$", item.decrypt_step_details.source_file_location))))))])
      )
    ])
    error_message = "all of: must be between 0 and 256 characters; Must be of the pattern ^\\$\\{(\\w+.)+\\w+\\}$"
  }
  validation {
    condition = alltrue([
      for k, v in var.transfer_workflows : (
        alltrue([for item in v.steps : (item.delete_step_details == null || (item.delete_step_details.source_file_location == null || ((length(item.delete_step_details.source_file_location) >= 0 && length(item.delete_step_details.source_file_location) <= 256) && (can(regex("^\\$\\{(\\w+.)+\\w+\\}$", item.delete_step_details.source_file_location))))))])
      )
    ])
    error_message = "all of: must be between 0 and 256 characters; Must be of the pattern ^\\$\\{(\\w+.)+\\w+\\}$"
  }
  validation {
    condition = alltrue([
      for k, v in var.transfer_workflows : (
        alltrue([for item in v.steps : (item.tag_step_details == null || (item.tag_step_details.source_file_location == null || ((length(item.tag_step_details.source_file_location) >= 0 && length(item.tag_step_details.source_file_location) <= 256) && (can(regex("^\\$\\{(\\w+.)+\\w+\\}$", item.tag_step_details.source_file_location))))))])
      )
    ])
    error_message = "all of: must be between 0 and 256 characters; Must be of the pattern ^\\$\\{(\\w+.)+\\w+\\}$"
  }
  # Note: 32 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

