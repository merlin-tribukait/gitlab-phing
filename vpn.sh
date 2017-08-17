#!/bin/sh
if [[ ${VPN_PASS} ]]; then
    echo "CONNECT TO VPN $VPN_URL $VPN_USER"
    echo $VPN_PASS | openconnect $VPN_URL -u $VPN_USER --no-xmlpost --juniper --passwd-on-stdin -b
fi