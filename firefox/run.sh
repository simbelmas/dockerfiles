#!/bin/bash -ex

# Ensure permissions are right
usermod -g ${GID} -u ${UID} svc
chown svc: /home/svc -R || true #don't stop if this fails as we can mount ro fs on / home
chown svc: /home/svc/host_pages -R

#Configure pulse client
sed "s/USER_ID/${UID}/" -i /home/svc/.config/pulse/client.conf

#run firefox with user
su svc -c "exec firefox --new-instance $@"
