#!/bin/bash -ex

# Ensure permissions are right
usermod -g ${GID} -u ${UID} svc
chown svc: /home/svc -R || true #don't stop if this fail as we can mount ro fs on / home

#run firefox with user
exec filezilla $@
