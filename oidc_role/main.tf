provider "aws" {
  region = var.aws_region
}

data "aws_caller_identity" "current" {}

data "tls_certificate" "github_actions" {
  url = "https://token.actions.githubusercontent.com"
}

resource "aws_iam_openid_connect_provider" "github_actions" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.github_actions.certificates[0].sha1_fingerprint]
}

resource "aws_iam_role" "github_actions" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.github_actions.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }
          StringLike = {
            "token.actions.githubusercontent.com:sub" = "repo:${var.github_org}/${var.github_repo}:*"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "github_actions" {
  name        = "${var.role_name}-policy"
  path        = "/"
  description = "Policy for GitHub Actions OIDC role"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:*",
          "rds:*",
          "s3:*",
          "route53:*",
          "cloudwatch:*",
          "logs:*",
          "iam:*",
          "kms:*",
          "elasticloadbalancing:*",
          "autoscaling:*",
          "cloudfront:*",
          "cloudformation:*",
          "sns:*",
          "sqs:*",
          "dynamodb:*",
          "apigateway:*",
          "lambda:*",
          "elasticache:*",
          "es:*",
          "application-autoscaling:*",
          "tag:*",
          "logs:DeleteResourcePolicy",
          "logs:ListTagsLogGroup",
          "logs:DeleteLogGroup",
          "logs:DescribeResourcePolicies",
          "logs:DescribeLogGroups",
          "ec2:DescribeVpcClassicLinkDnsSupport",
          "ec2:DescribeAvailabilityZones",
          "ec2:DescribeSubnets",
          "ec2:DescribeVpcClassicLink",
          "ec2:DescribeVpcs",
          "ec2:DescribeFlowLogs",
          "ec2:DescribeVpcAttribute",
          "ec2:DescribeAccountAttributes",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeNetworkAcls",
          "ec2:DescribeRouteTables",
          "iam:ListRolePolicies",
          "iam:PutRolePolicy",
          "iam:GetRole",
          "iam:ListAttachedRolePolicies",
          "iam:GetRolePolicy",
          "kms:CreateGrant",
          "kms:Decrypt",
          "kms:ListResourceTags",
          "kms:DescribeKey",
          "kms:GenerateDataKey",
          "kms:GetKeyRotationStatus",
          "kms:GetKeyPolicy",
          "rds:ListTagsForResource",
          "rds:CreateDBInstance",
          "rds:CreateDBSubnetGroup",
          "rds:AddTagsToResource",
          "rds:DescribeDBInstances",
          "rds:CreateTenantDatabase",
          "rds:DescribeDBSubnetGroups",
          "route53:CreateQueryLoggingConfig",
          "route53:ListResourceRecordSets",
          "route53:ListTagsForResource",
          "route53:GetHostedZone",
          "secretsmanager:CreateSecret",
          "secretsmanager:TagResource",
          "sts:GetCallerIdentity"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "github_actions" {
  role       = aws_iam_role.github_actions.name
  policy_arn = aws_iam_policy.github_actions.arn
}