data "aws_iam_policy_document" "this" {

  statement {
    sid = "Karpenter"
    actions = [
      "iam:PassRole",
      "ssm:GetParameter",
      "ec2:DescribeImages",
      "ec2:RunInstances",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeLaunchTemplates",
      "ec2:DescribeInstances",
      "ec2:DescribeInstanceTypes",
      "ec2:DescribeInstanceTypeOfferings",
      "ec2:DescribeAvailabilityZones",
      "ec2:DeleteLaunchTemplate",
      "ec2:CreateTags",
      "ec2:CreateLaunchTemplate",
      "ec2:CreateFleet",
      "ec2:DescribeSpotPriceHistory",
      "pricing:GetProducts",
    ]
    resources = [
      "*",
    ]
  }

  statement {
    sid = "ConditionalEC2Termination"

    condition {
      test     = "StringLike"
      variable = "ec2:ResourceTag/karpenter.sh/provisioner-name"
      values   = "*"
    }

    actions = [
      "ec2:TerminateInstances",
    ]
    resources = [
      "*",
    ]


  }


  statement {
    sid = "EKS"
    actions = [
      "eks:DescribeCluster",
    ]
    resources = [
      "*",
    ]
  }

}
