vnet_hub_address_space = "10.0.0.0/16"
vnet_hub_subnets = {
  adSubnet            = "10.0.1.0/24"
  poolSubnet          = "10.0.2.0/24"
  AzureFirewallSubnet = "10.0.0.0/26"
}
dc_private_ip_address = "10.0.1.4"
dc_ad_domain_name     = "contosohq.xyz"
dc_ad_netbios_name    = "CONTOSOHQ"