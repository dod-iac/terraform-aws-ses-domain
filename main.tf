/**
 * ## Usage
 *
 * Setup a SES domain and generate DKIM tokens.
 *
 * ```hcl
 * module "ses_domain" {
 *   source = "dod-iac/ses-domain/aws"
 *
 *   dkim = true
 *   domain = "example.com"
 * }
 * ```
 *
 * Setup a SES domain, verify using Route 53, generate DKIM tokens, and setup for DKIM signing using Route 53.
 *
 * ```hcl
 * module "ses_domain" {
 *   source = "dod-iac/ses-domain/aws"
 *
 *   dkim = true
 *   domain = "example.com"
 *   route53_dkim = true
 *   route53_verification = true
 *   route53_zone_id = var.route53_zone_id
 * }
 * ```
 *
 * ## Terraform Version
 *
 * Terraform 0.12. Pin module version to ~> 1.0.0 . Submit pull-requests to master branch.
 *
 * Terraform 0.11 is not supported.
 *
 * ## License
 *
 * This project constitutes a work of the United States Government and is not subject to domestic copyright protection under 17 USC § 105.  However, because the project utilizes code licensed from contributors and other third parties, it therefore is licensed under the MIT License.  See LICENSE file for more information.
 */


resource "aws_ses_domain_identity" "main" {
  domain = var.domain
}

resource "aws_route53_record" "ses_verification" {
  count = var.route53_verification ? 1 : 0

  zone_id = var.route53_zone_id
  name    = format("_amazonses.%s", aws_ses_domain_identity.main.id)
  type    = "TXT"
  ttl     = "600"
  records = [
    aws_ses_domain_identity.main.verification_token
  ]
}

resource "aws_ses_domain_identity_verification" "main" {
  count = var.route53_verification ? 1 : 0

  domain     = aws_ses_domain_identity.main.id
  depends_on = [aws_route53_record.ses_verification]
}

resource "aws_ses_domain_dkim" "main" {
  count  = var.dkim ? 1 : 0
  domain = aws_ses_domain_identity.main.domain
}

resource "aws_route53_record" "dkim" {
  count = var.route53_dkim ? 3 : 0

  zone_id = var.route53_zone_id
  name = format(
    "%s._domainkey.%s.",
    element(aws_ses_domain_dkim.main.0.dkim_tokens, count.index),
    var.domain,
  )
  type = "CNAME"
  ttl  = "600"
  records = [
    format(
      "%s.dkim.amazonses.com",
      element(aws_ses_domain_dkim.main.0.dkim_tokens, count.index)
    )
  ]
}
