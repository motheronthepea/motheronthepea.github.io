
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
  gsuite_mx_records = [
    "1 aspmx.l.google.com.",
    "10 aspmx2.googlemail.com.",
    "10 aspmx3.googlemail.com.",
    "5 alt2.aspmx.l.google.com.",
    "5 alt1.aspmx.l.google.com."
  ]
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

resource "ovh_domain_zone_record" "gsuite_site_verification" {
  zone      = local.be_zone
  fieldtype = "TXT"
  ttl       = local.ttl
  target    = "\"google-site-verification=yRsQtTu_Gp0VBi39gdKVOM5-OPibMoVclrwu7z1x-Gk\""
}

resource "ovh_domain_zone_record" "gsuite" {
  count     = length(local.gsuite_mx_records)
  zone      = local.be_zone
  fieldtype = "MX"
  ttl       = local.ttl
  target    = local.gsuite_mx_records[count.index]
}
