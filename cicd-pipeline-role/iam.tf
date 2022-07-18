resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"
  client_id_list = [
    "sts.amazonaws.com",
  ]
  thumbprint_list = [
    "6938fd4d98bab03faadb97b34396831e3780aea1"
  ]
  tags = local.common_tags
}

data "aws_iam_policy_document" "cicd_pipeline_permissions" {
  statement {
    sid = "TfStateLocking"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem",
      "dynamodb:DescribeTable",
      "dynamodb:DescribeContinuousBackups",
      "dynamodb:DescribeTimeToLive",
      "dynamodb:ListTagsOfResource"
    ]
    resources = [
      "arn:aws:dynamodb:*:${var.aws_account}:table/*"
    ]
  }
  statement {
    sid = "TfStateBucketAccess"
    actions = [
      "s3:ListBucket",
      "s3:GetBucketAcl",
      "s3:GetBucketCORS",
      "s3:GetBucketLocation",
      "s3:GetBucketLogging",
      "s3:GetBucketNotification",
      "s3:GetBucketObjectLockConfiguration",
      "s3:GetBucketOwnershipControls",
      "s3:GetBucketPolicy",
      "s3:GetBucketPolicyStatus",
      "s3:GetBucketPublicAccessBlock",
      "s3:GetBucketRequestPayment",
      "s3:GetBucketTagging",
      "s3:GetBucketVersioning",
      "s3:GetBucketWebsite",
      "s3:GetAccelerateConfiguration",
      "s3:GetEncryptionConfiguration",
      "s3:GetLifecycleConfiguration",
      "s3:GetReplicationConfiguration"
    ]
    resources = [
      "arn:aws:s3:::*"
    ]
  }
  statement {
    sid = "TfStateFileAccess"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = [
      "arn:aws:s3:::*/*"
    ]
  }
}

resource "aws_iam_policy" "cicd_pipeline" {
  name   = "${local.component_name}-policy"
  policy = data.aws_iam_policy_document.cicd_pipeline_permissions.json
  tags   = local.common_tags
}

data "aws_iam_policy_document" "cicd_pipeline_role_trust_relationship" {
  statement {
    principals {
      type = "Federated"
      identifiers = [
        resource.aws_iam_openid_connect_provider.github.arn
      ]
    }
    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values = [
        "sts.amazonaws.com"
      ]
    }
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values = [
        "repo:devhalos/*:*"
      ]
    }
  }
}

resource "aws_iam_role" "cicd_pipeline" {
  name = "${local.component_name}-role"
  managed_policy_arns = [
    aws_iam_policy.cicd_pipeline.arn
  ]
  assume_role_policy = data.aws_iam_policy_document.cicd_pipeline_role_trust_relationship.json
}
