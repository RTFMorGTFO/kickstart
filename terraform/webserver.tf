terraform {
  required_providers {
    virtualbox = {
      source = "terra-farm/virtualbox"
      version = "0.2.2-alpha.1"
    }
  }
}

# There are currently no configuration options for the provider itself.

resource "virtualbox_vm" "webserver" {
  count     = 1
  
  name      = "bsweb"
  image     = "/Users/bryan/Desktop/tools/OVAs/exported/webserver01.ova"
  cpus      = 2
  memory    = "2 gib"
  #user_data = file("${path.module}/user_data")

  network_adapter {
    type           = "bridged"
    host_interface = "Realtek USB GbE Family Controller"
  }
}

/*
output "IPAddr" {
  value = element(virtualbox_vm.webserver.*.network_adapter.0.ipv4_address, 1)
}

output "IPAddr_2" {
  value = element(virtualbox_vm.webserver.*.network_adapter.0.ipv4_address, 2)
}
*/