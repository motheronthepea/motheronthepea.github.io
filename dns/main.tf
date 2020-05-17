
provider "ovh" {
  endpoint           = "ovh-eu"
  version            = "~> 0.5"
  application_key    = var.ovh_application_key
  application_secret = var.ovh_application_secret
  consumer_key       = var.ovh_consumer_key
}

locals {
  zone = "motheronthepea.be"
  ttl  = "86400"
}

resource "ovh_domain_zone_record" "motheronthepea_be" {
  zone      = local.zone
  fieldtype = "A"
  ttl       = local.ttl
  target    = var.domain_name_ip
}
