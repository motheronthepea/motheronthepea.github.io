
provider "ovh" {
  endpoint           = "ovh-eu"
  version            = "~> 0.5"
  application_key    = var.ovh_application_key
  application_secret = var.ovh_application_secret
  consumer_key       = var.ovh_consumer_key
}

locals {
  zone_be  = "motheronthepea.be"
  zone_com = "motheronthepea.com"
  zone_eu  = "motheronthepea.eu"

  ovh_ip = "213.186.33.5"

  name_servers = [
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

  spf = "\"v=spf1 include:_spf.google.com ~all\""
}

module "be" {
  source = "./modules/zone"

  zone         = local.zone_be
  name_servers = local.name_servers
  ipv4         = var.website_ip
  aliases = [
    { subdomain = "www", target = "motheronthepea.github.io." }
  ]

  google_site_verification = "yRsQtTu_Gp0VBi39gdKVOM5-OPibMoVclrwu7z1x-Gk"

  mx  = local.gsuite_mx_records
  spf = local.spf
}

module "com" {
  source = "./modules/zone"

  zone         = local.zone_com
  name_servers = local.name_servers
  ipv4         = [local.ovh_ip]
  aliases = [
    { subdomain = "www", target = "${local.zone_com}." }
  ]
  redirections = [
    { subdomain = "", type = "visiblePermanent", target = "http://motheronthepea.be" }
  ]
}

module "eu" {
  source = "./modules/zone"

  zone         = local.zone_eu
  name_servers = local.name_servers
  ipv4         = [local.ovh_ip]
  aliases = [
    { subdomain = "www", target = "${local.zone_eu}." }
  ]
  redirections = [
    { subdomain = "", type = "visiblePermanent", target = "http://motheronthepea.be" }
  ]
}
