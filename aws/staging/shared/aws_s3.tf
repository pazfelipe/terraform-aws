resource "aws_s3_bucket" "this" {
  for_each      = local.buckets
  bucket        = each.value.name
  tags          = each.value.tags
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "this" {
  for_each                = local.buckets
  bucket                  = aws_s3_bucket.this[each.key].id
  block_public_acls       = each.value.public_access_block.block_public_acls
  block_public_policy     = each.value.public_access_block.block_public_policy
  ignore_public_acls      = each.value.public_access_block.ignore_public_acls
  restrict_public_buckets = each.value.public_access_block.restrict_public_buckets
}

resource "aws_s3_bucket_ownership_controls" "this" {
  for_each = local.buckets
  bucket   = aws_s3_bucket.this[each.key].id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  for_each = { for bucket in local.buckets : bucket.name => bucket if lookup(bucket, "lifecycle_rule", null) != null }
  bucket   = aws_s3_bucket.this[each.key].id

  rule {
    id     = "delete-objects-${each.key}"
    status = each.value.lifecycle_rule.status
    expiration {
      days = each.value.lifecycle_rule.expiration.days
    }

    transition {
      days          = each.value.lifecycle_rule.transition.days
      storage_class = each.value.lifecycle_rule.transition.storage_class
    }
  }

}

resource "aws_s3_bucket_versioning" "this" {
  for_each = local.buckets
  bucket   = aws_s3_bucket.this[each.key].id
  versioning_configuration {
    status = each.value.versioning.status
  }
}
