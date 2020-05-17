
provider "ovh" {
  endpoint           = "ovh-eu"
  version            = "~> 0.5"
  application_key    = var.ovh_application_key
  application_secret = var.ovh_application_secret
  consumer_key       = var.ovh_consumer_key
}

locals {
  # OVH does not accept a TTL lower than 60 !
  ttl     = 86400
  be_zone = "motheronthepea.be"

  com_zone    = "motheronthepea.com"
  com_zone_ip = "213.186.33.5"

  eu_zone    = "motheronthepea.eu"
  eu_zone_ip = "213.186.33.5"

  ns_records = [
    "dns101.ovh.net.",
    "ns101.ovh.net."
  ]
  gsuite_mx_records = [
    "1 aspmx.l.google.com.",
    "10 aspmx2.googlemail.com.",
    "10 aspmx3.googlemail.com.",
    "5 alt2.aspmx.l.google.com.",
    "5 alt1.aspmx.l.google.com."
  ]
}

resource "ovh_domain_zone_record" "be_name_server" {
  count     = length(local.ns_records)
  zone      = local.be_zone
  fieldtype = "NS"
  ttl       = local.ttl
  target    = local.ns_records[count.index]
}

resource "ovh_domain_zone_record" "be_motheronthepea" {
  count     = length(var.website_ip)
  zone      = local.be_zone
  fieldtype = "A"
  ttl       = 60
  target    = var.website_ip[count.index]
}

resource "ovh_domain_zone_record" "be_motheronthepea_www" {
  zone      = local.be_zone
  subdomain = "www"
  fieldtype = "CNAME"
  ttl       = local.ttl
  target    = "${local.be_zone}."
}

resource "ovh_domain_zone_record" "be_gsuite_site_verification" {
  zone      = local.be_zone
  fieldtype = "TXT"
  ttl       = local.ttl
  target    = "\"google-site-verification=yRsQtTu_Gp0VBi39gdKVOM5-OPibMoVclrwu7z1x-Gk\""
}

resource "ovh_domain_zone_record" "be_gsuite" {
  count     = length(local.gsuite_mx_records)
  zone      = local.be_zone
  fieldtype = "MX"
  ttl       = local.ttl
  target    = local.gsuite_mx_records[count.index]
}

resource "ovh_domain_zone_record" "com_name_server" {
  count     = length(local.ns_records)
  zone      = local.com_zone
  fieldtype = "NS"
  ttl       = local.ttl
  target    = local.ns_records[count.index]
}

resource "ovh_domain_zone_record" "com_motheronthepea" {
  zone      = local.com_zone
  fieldtype = "A"
  ttl       = local.ttl
  target    = local.com_zone_ip
}

resource "ovh_domain_zone_record" "com_motheronthepea_www" {
  zone      = local.com_zone
  subdomain = "www"
  fieldtype = "CNAME"
  ttl       = local.ttl
  target    = "${local.com_zone}."
}

resource "ovh_domain_zone_redirection" "com_motheronthepea" {
  zone      = local.com_zone
  subdomain = ""
  type      = "visiblePermanent"
  target    = "http://motheronthepea.be"
}

resource "ovh_domain_zone_record" "eu_name_server" {
  count     = length(local.ns_records)
  zone      = local.eu_zone
  fieldtype = "NS"
  ttl       = local.ttl
  target    = local.ns_records[count.index]
}

resource "ovh_domain_zone_record" "eu_motheronthepea" {
  zone      = local.eu_zone
  fieldtype = "A"
  ttl       = local.ttl
  target    = local.eu_zone_ip
}

resource "ovh_domain_zone_record" "eu_motheronthepea_www" {
  zone      = local.eu_zone
  subdomain = "www"
  fieldtype = "CNAME"
  ttl       = local.ttl
  target    = "${local.eu_zone}."
}

resource "ovh_domain_zone_redirection" "eu_motheronthepea" {
  zone      = local.eu_zone
  subdomain = ""
  type      = "visiblePermanent"
  target    = "http://motheronthepea.be"
}
