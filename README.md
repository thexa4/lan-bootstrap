# lan-bootstrap
A set of scripts to setup all the necessary infrastructure for a lan party

## Host configuration
Installing a proxmox master or follower sometimes requires configuration for your local environment (which network interface to use, etc.). These parameters can be configured in advance. This step is optional: useful defaults are given for every parameter.

Copy `includes/config.example` to `includes/config` and adapt as needed. Note: you might need to change the configuration before setting up the master or joining a follower to the cluster.

## Usage
### ./lan init cluster_name domain container_root_pw
Initializes the master with a given cluster name, domain name and the root passwords for
the puppet and dns containers

### ./lan join master_hostname
Joins a proxmox node to the cluster

### ./lan add hostname password
Creates a new container with a given hostname and password.
If the hostname matches any of the supported roles (can have a trailing digit)
the correct puppet manifest will be applied.

### ./lan sign fqdn
Signs the puppet key of the given fully qualified domain name.
Should run automatically when using the add command.

### ./lan destroy vmid
Destroys a container living on this proxmox node

### ./lan clean vmid fqdn
Tries to clean up as much as possible for the given container (puppet keys, domain names)
Should run automatically when using the destroy command.

### ./lan trigger vmid hostname
Runs the triggers again for the given container, should run automatically when using
the add command.

### ./lan pull
Updates the git repositories on this node, the master and in the puppet container.
It's useful to use this before adding containers.

## Setup
In order to use this script you need one or more proxmox nodes. You can find
instructions on how to install proxmox on: http://www.proxmox.com

## Examples
Initializing a basic lan server:

	#> apt-get install git
    #> mkdir -r /opt/max/
    #> cd /opt/max
    #> git clone https://github.com/thexa4/lan-bootstrap
    #> cd lan-bootstrap
    #> ./lan init lanparty party.example.com swordfish
    #> ./lan add dhcp swordfish

Adding the steam cache:

	#> ./lan add cache1 swordfish

Removing the dhcp server:

	#> ./lan destroy 100

## Modules
Currently the following modules have been implemented:

 - Dhcp
 - Mumble
 - Dns (ns)
 - Samba
 - Trackmania
 - Steam cache (cache)
 - Openttd

## Special thanks
 - http://blog.multiplay.co.uk/ for publishing the steam cache
