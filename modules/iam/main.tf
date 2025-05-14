resource "aws_iam_role" "this" {
  name               = var.role_name
  assume_role_policy = var.assume_role_policy
  tags = {
    Environment = var.env_name
    Name        = var.role_name
  }
}

resource "aws_iam_role_policy_attachment" "this" {
  count      = length(var.managed_policy_arns)
  role       = aws_iam_role.this.name
  policy_arn = var.managed_policy_arns[count.index]
}

resource "aws_iam_instance_profile" "this" {
  name = "${var.role_name}-instance-profile"
  role = aws_iam_role.this.name
}

resource "aws_iam_policy" "custom" {
  count       = var.custom_policy_json != null ? 1 : 0
  name        = var.custom_policy_name
  policy      = var.custom_policy_json
  description = "Política personalizada adjunta al rol"
}

resource "aws_iam_role_policy_attachment" "custom_attach" {
  count      = var.custom_policy_json != null ? 1 : 0
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.custom[0].arn
}

