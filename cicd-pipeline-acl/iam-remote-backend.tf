
data "aws_iam_policy_document" "cicd_pipeline_permissions_remote_backend" {
  statement {
    sid = "TfStateLocking"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem",
      "dynamodb:CreateTable",
      "dynamodb:DescribeTable",
      "dynamodb:DescribeContinuousBackups",
      "dynamodb:DescribeTimeToLive",
      "dynamodb:ListTagsOfResource",
      "dynamodb:TagResource"
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
      "s3:GetReplicationConfiguration",
      "s3:CreateBucket",
      "s3:PutEncryptionConfiguration",
      "s3:PutBucketTagging",
      "s3:PutBucketPublicAccessBlock",
      "s3:PutBucketVersioning",
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
  name   = "${local.component_name}-remote-backend-policy"
  policy = data.aws_iam_policy_document.cicd_pipeline_permissions_remote_backend.json
}

resource "aws_iam_role" "cicd_pipeline" {
  name = "${local.component_name}-remote-backend-role"
  managed_policy_arns = [
    aws_iam_policy.cicd_pipeline.arn
  ]
  assume_role_policy = data.aws_iam_policy_document.cicd_pipeline_role_trust_relationship.json
}
