resource "aws_iam_role" "s3_hosting_codepipeline_role" {
  name = "codepipeline-role-s3-hosting-2397710"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "codepipeline.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "s3_hosting_codepipeline_policy" {
  name = "codepipeline-s3-access-policy-2397710"
  role = aws_iam_role.s3_hosting_codepipeline_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:PutObjectAcl",
          "s3:ListBucket",
          "s3:DeleteObject"
        ],
        Resource = [
          "${aws_s3_bucket.s3_hosting_bucket.arn}",
          "${aws_s3_bucket.s3_hosting_bucket.arn}/*"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "codedeploy:CreateDeployment",
          "codedeploy:GetApplication",
          "codedeploy:GetDeployment",
          "codedeploy:GetDeploymentConfig",
          "codedeploy:RegisterApplicationRevision",
          "codedeploy:ListApplications",
          "codedeploy:ListDeploymentConfigs",
          "codedeploy:ListDeployments",
          "codedeploy:ListApplicationRevisions"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "codebuild:StartBuild",
          "codebuild:BatchGetBuilds",
          "codebuild:StopBuild"
        ],
        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_role" "s3_hosting_codebuild_role" {
  name = "codebuild-role-s3-hosting-2397710"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "codebuild.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "s3_hosting_codebuild_policy" {
  name = "codebuild-s3-access-policy-2397710"
  role = aws_iam_role.s3_hosting_codebuild_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:PutObjectAcl",
          "s3:ListBucket",
          "s3:DeleteObject"
        ],
        Resource = [
          "${aws_s3_bucket.s3_hosting_bucket.arn}",
          "${aws_s3_bucket.s3_hosting_bucket.arn}/*"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}
