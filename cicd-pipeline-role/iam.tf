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
      "dynamodb:DeleteItem"
    ]
    resources = [
      "arn:aws:dynamodb:*:${var.aws_account}:table/*"
    ]
  }
  statement {
    sid = "TfStateBucketAccess"
    actions = [
      "s3:ListBucket"
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
