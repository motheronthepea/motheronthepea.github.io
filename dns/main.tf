
provider "ovh" {
  endpoint           = "ovh-eu"
  version            = "~> 0.5"
  application_key    = var.ovh_application_key
  application_secret = var.ovh_application_secret
  consumer_key       = var.ovh_consumer_key
}

locals {
  ttl  = "86400"
  be_zone = "motheronthepea.be"
}

resource "ovh_domain_zone_record" "motheronthepea_be" {
  zone      = local.be_zone
  fieldtype = "A"
  ttl       = local.ttl
  target    = var.website_ip
}

resource "ovh_domain_zone_record" "www_motheronthepea_be" {
  zone      = local.be_zone
  subdomain = "www"
  fieldtype = "CNAME"
  ttl       = local.ttl
  target    = "${local.be_zone}."
}
