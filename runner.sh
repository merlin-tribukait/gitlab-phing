#!/bin/sh
if [ -z "$DRONE_WORKSPACE" ]; then
    export DRONE_WORKSPACE="/"
fi


cd $DRONE_WORKSPACE
if [ -z "$PLUGIN_BUILDFILE" ]; then
    export PLUGIN_BUILDFILE="build.xml"
fi

echo "$SSH_KEY" > /root/.ssh/id_rsa && chmod 600 /root/.ssh/id_rsa

echo "PROCESSING USING BUILDFILE $PLUGIN_BUILDFILE"
ip tuntap add vpn0 mode tun user root

if [[ ${VPN_PASS} ]]; then
    echo "CONNECT TO VPN $VPN_URL $VPN_USER"
    echo $VPN_PASS | openconnect $VPN_URL -u $VPN_USER --no-xmlpost --juniper --passwd-on-stdin -b
fi

echo "Execute phing now"
exec phing -f $PLUGIN_BUILDFILE -Dsettings.tag=$DRONE_TAG