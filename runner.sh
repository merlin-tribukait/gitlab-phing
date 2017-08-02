#!/bin/sh
cd $DRONE_WORKSPACE
if [ -z "$PLUGIN_BUILDFILE" ]; then
    export PLUGIN_BUILDFILE="/$DRONE_WORKSPACE/build.yml"
fi

echo "$SSH_KEY" > /root/.ssh/id_rsa && chmod 600 /root/.ssh/id_rsa

echo "PROCESSING USING BUILDFILE $DRONE_WORKSPACE/$PLUGIN_BUILDFILE"

phing -f $PLUGIN_BUILDFILE -Dsettings.tag=$DRONE_TAG