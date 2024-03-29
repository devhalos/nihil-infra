resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"
  client_id_list = [
    "sts.amazonaws.com",
  ]
  thumbprint_list = [
    "6938fd4d98bab03faadb97b34396831e3780aea1"
  ]
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


data "aws_iam_policy" "cicd_pipeline" {
  arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

resource "aws_iam_role" "cicd_pipeline" {
  name = local.component_name
  managed_policy_arns = [
    data.aws_iam_policy.cicd_pipeline.arn
  ]
  assume_role_policy = data.aws_iam_policy_document.cicd_pipeline_role_trust_relationship.json
}
