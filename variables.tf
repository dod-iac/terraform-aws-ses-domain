variable "domain" {
  type        = string
  description = "The domain name to assign to SES."
}

variable "dkim" {
  type        = bool
  description = "Generate DKIM tokens for the SES domain."
  default     = false
}

variable "route53_dkim" {
  type        = bool
  description = "Adds CNAME records to the provided Route 53 zone to enable DKIM signing."
  default     = false
}

variable "route53_verification" {
  type        = bool
  description = "Adds TXT record to the provided Route 53 zone to verify the domain."
  default     = false
}

variable "route53_zone_id" {
  type        = string
  description = "The id of the Route 53 zone that is used for domain verification and DKIM records."
  default     = ""
}
