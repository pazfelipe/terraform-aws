locals {
  buckets = {
    "bucket-example" = {
      name = "bucket-example"
      acl  = "private",
      versioning = {
        status = "Enabled"
      }
      tags = {
        Environment = "staging"
        Terraform        = true
      }

      public_access_block = {
        block_public_acls       = true
        block_public_policy     = true
        ignore_public_acls      = true
        restrict_public_buckets = true
      }

      lifecycle_rule = {
        status = "Enabled"
        expiration = {
          days = 730
        }

        transition = {
          days          = 90
          storage_class = "GLACIER"
        }
      }
    }

  }

  users = {
    "user_x" = {
      username = "user_x@email.com"
      console  = true

      path : "/"

      tags = {
        Environment = "staging"
        Terraform        = true
      }

      user_groups = ["Administrator"]
    }
    "s3_mamanger" = {
      username = "s3_manager"
      console  = false

      path : "/"

      tags = {
        Environment = "staging"
        Terraform        = true
      }

      user_groups = ["S3Managers"]
    }
  }

  user_groups = {
    "s3-managers" = {
      name = "S3Managers"
      path = "/"

      tags = {
        Environment = "staging"
        Terraform        = true
      }

      policy = {
        name : "s3-managers-policy"
        Statement = [
          {
            Action = [
              "s3:*",
            ]
            Effect   = "Allow"
            Resource = "*"
          },
        ]
      }
    }
  }

  # Filter users who have access key enabled to create aws_iam_access_key resource
  users_with_access_key = tomap({
    for k, v in local.users : k => v if lookup(v, "access_key", false) == true
  })
}
