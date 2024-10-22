<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Usage

Setup a SES domain and generate DKIM tokens.

```hcl
module "ses_domain" {
  source = "dod-iac/ses-domain/aws"

  dkim = true
  domain = "example.com"
}
```

Setup a SES domain, verify using Route 53, generate DKIM tokens, and setup for DKIM signing using Route 53.

```hcl
module "ses_domain" {
  source = "dod-iac/ses-domain/aws"

  dkim = true
  domain = "example.com"
  route53_dkim = true
  route53_verification = true
  route53_zone_id = var.route53_zone_id
}
```

## Terraform Version

Terraform 0.12. Pin module version to ~> 1.0.0 . Submit pull-requests to master branch.

Terraform 0.11 is not supported.

## License

This project constitutes a work of the United States Government and is not subject to domestic copyright protection under 17 USC § 105.  However, because the project utilizes code licensed from contributors and other third parties, it therefore is licensed under the MIT License.  See LICENSE file for more information.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.0 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [aws_route53_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) |
| [aws_ses_domain_dkim](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_dkim) |
| [aws_ses_domain_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_identity) |
| [aws_ses_domain_identity_verification](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_identity_verification) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dkim | Generate DKIM tokens for the SES domain. | `bool` | `false` | no |
| domain | The domain name to assign to SES. | `string` | n/a | yes |
| route53\_dkim | Adds CNAME records to the provided Route 53 zone to enable DKIM signing. | `bool` | `false` | no |
| route53\_verification | Adds TXT record to the provided Route 53 zone to verify the domain. | `bool` | `false` | no |
| route53\_zone\_id | The id of the Route 53 zone that is used for domain verification and DKIM records. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| dkim\_tokens | DKIM tokens generated by SES. These tokens should be used to create CNAME records used to verify SES Easy DKIM. |
| domain\_identity\_arn | The ARN of the domain identity. |
| domain\_identity\_id | The ID of the domain identity. |
| domain\_verification\_token | A code which when added to the domain as a TXT record will signal to SES that the owner of the domain has authorised SES to act on their behalf. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
