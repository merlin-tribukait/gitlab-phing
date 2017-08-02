#!/bin/bash
cd $DRONE_WORKSPACE
if [ -z "$PLUGIN_BUILDFILE" ]; then
    export PLUGIN_BUILDFILE='build.yml'
fi


phing -f $PLUGIN_BUILDFILE -Dsettings.tag=$DRONE_TAG