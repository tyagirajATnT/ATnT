output "role_arn" {
  description = "The ARN of the IAM role for GitHub Actions"
  value       = aws_iam_role.github_actions.arn
}

output "role_name" {
  description = "The name of the IAM role for GitHub Actions"
  value       = aws_iam_role.github_actions.name
}

output "policy_arn" {
  description = "The ARN of the custom policy"
  value       = aws_iam_policy.github_actions.arn
}

output "github_actions_oidc_provider_arn" {
  description = "The ARN of the GitHub Actions OIDC provider"
  value       = aws_iam_openid_connect_provider.github_actions.arn
}