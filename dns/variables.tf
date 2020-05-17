
variable "domain_name_ip" {
  description = "Target IP address for the domain name motheronthepea.be"
  type        = string
  default     = "185.3.216.250"
}

variable "ovh_application_key" {
  type = string
}

variable "ovh_application_secret" {
  type = string
}

variable "ovh_consumer_key" {
  type = string
}
