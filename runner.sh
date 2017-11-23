#!/bin/sh

cd $CI_PROJECT_DIR

if [ -z "$PLUGIN_BUILDFILE" ]; then
    echo "No build file specified, try default build file.";
    export PLUGIN_BUILDFILE="build.xml"
fi

echo "Check for build file ${PHING_BUILDFILE}"
if [ ! -f "$PLUGIN_BUILDFILE" ]; then
    echo "Using default build file provide by image."
    export PLUGIN_BUILDFILE="/build.xml"
fi


mkdir /root/.ssh
echo "$SSH_KEY" > /root/.ssh/id_rsa

chmod 600 /root/.ssh/id_rsa
echo "Start processing $PHING_BUILDFILE ."
phing -f $PLUGIN_BUILDFILE -Dsettings.tag=$CI_COMMIT_TAG