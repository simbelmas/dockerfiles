#!/bin/sh

scriptdir=$(readlink -f $(dirname $0))
echo Copying application to writtable folder
if [ ! -d /opt/mediaData/client ] ; then
    mkdir /opt/mediaData/client
fi
cp -rf ${scriptdir}/* /opt/mediaData/client

echo Launch rdtclient
cd /opt/mediaData/client/
exec dotnet /opt/mediaData/client/RdtClient.Web.dll