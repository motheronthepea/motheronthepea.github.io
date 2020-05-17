
provider "ovh" {
  endpoint           = "ovh-eu"
  version            = "~> 0.5"
  application_key    = var.ovh_application_key
  application_secret = var.ovh_application_secret
  consumer_key       = var.ovh_consumer_key
}

locals {
  be_zone  = "motheronthepea.be"
  be_zone_ttl = 86400

  com_zone = "motheronthepea.com"
  com_zone_ip = "213.186.33.5"
  com_zone_ttl = 86400

  eu_zone = "motheronthepea.eu"
  eu_zone_ip = "213.186.33.5"
  eu_zone_ttl = 86400

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
  ttl       = local.be_zone_ttl
  target    = local.ns_records[count.index]
}

resource "ovh_domain_zone_record" "be_motheronthepea" {
  zone      = local.be_zone
  fieldtype = "A"
  ttl       = local.be_zone_ttl
  target    = var.website_ip
}

resource "ovh_domain_zone_record" "be_motheronthepea_www" {
  zone      = local.be_zone
  subdomain = "www"
  fieldtype = "CNAME"
  ttl       = local.be_zone_ttl
  target    = "${local.be_zone}."
}

resource "ovh_domain_zone_record" "be_gsuite_site_verification" {
  zone      = local.be_zone
  fieldtype = "TXT"
  ttl       = local.be_zone_ttl
  target    = "\"google-site-verification=yRsQtTu_Gp0VBi39gdKVOM5-OPibMoVclrwu7z1x-Gk\""
}

resource "ovh_domain_zone_record" "be_gsuite" {
  count     = length(local.gsuite_mx_records)
  zone      = local.be_zone
  fieldtype = "MX"
  ttl       = local.be_zone_ttl
  target    = local.gsuite_mx_records[count.index]
}

resource "ovh_domain_zone_record" "com_name_server" {
  count     = length(local.ns_records)
  zone      = local.com_zone
  fieldtype = "NS"
  ttl       = local.com_zone_ttl
  target    = local.ns_records[count.index]
}

resource "ovh_domain_zone_record" "com_motheronthepea" {
  zone      = local.com_zone
  fieldtype = "A"
  ttl       = local.com_zone_ttl
  target    = local.com_zone_ip
}

resource "ovh_domain_zone_record" "com_motheronthepea_www" {
  zone      = local.com_zone
  subdomain = "www"
  fieldtype = "CNAME"
  ttl       = local.com_zone_ttl
  target    = "${local.com_zone}."
}

resource "ovh_domain_zone_redirection" "com_motheronthepea" {
  zone = local.com_zone
  subdomain = ""
  type = "visiblePermanent"
  target = "http://motheronthepea.be"
}

resource "ovh_domain_zone_record" "eu_name_server" {
  count     = length(local.ns_records)
  zone      = local.eu_zone
  fieldtype = "NS"
  ttl       = local.eu_zone_ttl
  target    = local.ns_records[count.index]
}

resource "ovh_domain_zone_record" "eu_motheronthepea" {
  zone      = local.eu_zone
  fieldtype = "A"
  ttl       = local.eu_zone_ttl
  target    = local.eu_zone_ip
}

resource "ovh_domain_zone_record" "eu_motheronthepea_www" {
  zone      = local.eu_zone
  subdomain = "www"
  fieldtype = "CNAME"
  ttl       = local.eu_zone_ttl
  target    = "${local.eu_zone}."
}

resource "ovh_domain_zone_redirection" "eu_motheronthepea" {
  zone = local.eu_zone
  subdomain = ""
  type = "visiblePermanent"
  target = "http://motheronthepea.be"
}
