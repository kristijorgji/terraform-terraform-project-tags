locals {
  tags = merge(local.generated_tags, var.tags)

  tags_as_list_of_maps = flatten([
    for key in keys(local.tags) : merge(
      {
        key   = key
        value = local.tags[key]
    }, var.additional_tag_map)
  ])

  tags_context = {
    project            = lower(var.project)
    region             = lower(var.region)
    environment        = lower(var.environment)
    parent             = lower(var.parent)
    terraform_provider = lower(var.terraform_provider)
  }

  generated_tags = { for l in keys(local.tags_context) : title(l) => local.tags_context[l] if length(local.tags_context[l]) > 0 }
}
