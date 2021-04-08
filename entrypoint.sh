#!/bin/bash

# we need to source apache's envvars in order to configure apache properly
. /etc/apache2/envvars

# run apache not as daemon (in the foreground)
exec apache2 -D FOREGROUND
