output "cicd_pipeline_role_arn" {
  value = aws_iam_role.cicd_pipeline.arn
}

output "cicd_pipeline_role_name" {
  value = aws_iam_role.cicd_pipeline.name
}
