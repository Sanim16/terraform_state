data "aws_caller_identity" "current" {}

module "kms" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-kms.git?ref=fe1beca2118c0cb528526e022a53381535bb93cd" # commit hash of version 3.1.0

  description = "Backend management key"
  key_usage   = "ENCRYPT_DECRYPT"

  # Policy
  key_administrators                = [data.aws_caller_identity.current.arn, "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root", "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/Aws_admin_Sani"]
  key_owners                        = [data.aws_caller_identity.current.arn, "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root", "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/Aws_admin_Sani"]
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
