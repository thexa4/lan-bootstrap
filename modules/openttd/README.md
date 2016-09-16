#OpenTTD
Installs an OpenTTD server. Warning, this uses rc.local to start it up automatically. Restart the machine to bring the server up.

This module is meant to be run in isolation in a container / vm, not alongside other services.

##Configuration
You can set the following variables:

* `$version` - The version of the game to download from the OpenTTD website
* `$gfx_version` - The version of the graphics to download from the OpenTTD website
