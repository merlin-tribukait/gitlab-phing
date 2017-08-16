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

if [[ ${PLUGIN_VPN_PASS} ]]; then
    echo "CONNECT TO VPN $PLUGIN_VPN_URL $PLUGIN_VPN_USER"
    echo $PLUGIN_VPN_PASS | openconnect $PLUGIN_VPN_URL -u $PLUGIN_VPN_USER --no-xmlpost --juniper --passwd-on-stdin -b
fi

exec phing -f $PLUGIN_BUILDFILE -Dsettings.tag=$DRONE_TAG