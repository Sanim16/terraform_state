data "aws_caller_identity" "current" {}

module "kms" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-kms.git?ref=af1d45558a6073c017a732d2273efcc733b34d0f" # commit hash of version 4.2.1

  description = "Backend management key"
  key_usage   = "ENCRYPT_DECRYPT"

  # Policy
  key_administrators                = [data.aws_caller_identity.current.arn, "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root", "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/momoh-admin-aws"]
  key_owners                        = [data.aws_caller_identity.current.arn, "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root", "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/momoh-admin-aws"]
  key_service_roles_for_autoscaling = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"]

  deletion_window_in_days = 7

  # Aliases
  aliases = ["tf_state_management"]

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Usage       = "Tf_state_management"
  }
}
