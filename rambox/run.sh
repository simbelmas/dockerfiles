#!/bin/bash -ex

# Ensure permissions are right
usermod -u ${UID} -g ${GID} svc
chown svc: /home/svc

#run firefox with user
su svc -c "exec rambox"
