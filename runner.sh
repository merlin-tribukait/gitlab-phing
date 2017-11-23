#!/bin/sh

cd $CI_PROJECT_DIR

if [ -z "$PHING_BUILDFILE" ]; then
    echo "No build file specified, try default build file.";
    export PHING_BUILDFILE="build.xml"
fi

echo "Check for build file ${PHING_BUILDFILE}"
if [ ! -f "$PHING_BUILDFILE" ]; then
    echo "Using default build file provide by image."
    export PHING_BUILDFILE="/build.xml"
fi


mkdir /root/.ssh
echo "$SSH_KEY" > /root/.ssh/id_rsa

chmod 600 /root/.ssh/id_rsa
echo "Start processing $PHING_BUILDFILE ."
phing -f $PHING_BUILDFILE -Dsettings.tag=$CI_COMMIT_TAG