#Game Cache
Configures a caching proxy that sits in between Steam clients on a lan network and the internet servers to reduce bandwidth for games that are downloaded multiple times.

Based on http://block.multiplay.co.uk.

##Configuration
Create a machine with this module installed, add override entries to your DNS server that makes the following domains point to your newly created server:

* cs.steampowered.com
* content1.steampowered.com
* content2.steampowered.com
* content3.steampowered.com
* content4.steampowered.com
* content5.steampowered.com
* content6.steampowered.com
* content7.steampowered.com
* content8.steampowered.com

##See also
A set of scripts that can set up this alongside with other services needed for a lan party setting: (lan-bootstrap)[https://github.com/thexa4/lan-bootstrap].
