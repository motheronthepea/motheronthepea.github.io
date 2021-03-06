
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

  spf   = "\"v=spf1 include:_spf.google.com ~all\""
  dkim  = "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC1DQ5KWuaqjgm3guSmlKY2uUISnzxHUIi/RZYAE+92yF1Wg7Wkhzh3FpGMBPuJJbHg6brqs+1ebcguE5rx8XcAj5hcWwleLZwhjWZjVALPQM4ok+1crdeW0BAQQbuOBVomitervSIjYzkbPSKZHAanBM/+n9/bp2nzO5fvBNRPewIDAQAB"
  dmarc = "v=DMARC1; p=none; rua=mailto:admin@wayofthinking.be"
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

  mx    = local.gsuite_mx_records
  spf   = local.spf
  dkim  = local.dkim
  dmarc = local.dmarc
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

  dmarc = local.dmarc
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

  dmarc = local.dmarc
}
