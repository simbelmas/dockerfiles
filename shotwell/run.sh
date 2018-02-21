#!/bin/bash -ex

# Ensure permissions are right
usermod -g ${GID} -u ${UID} svc
chown svc: /home/svc -R || true #don't stop if this fail as we can mount ro fs on / home

#Configure pulse client
sed "s/USER_ID/${UID}/" -i /home/svc/.config/pulse/client.conf

#Create link to ensure pictures path is valid in shotwell database
ln -s /home/svc /home/${USER}

# configure shotwell
su svc -c "gsettings set org.yorba.shotwell.preferences.files auto-import true"
su svc -c "gsettings set org.yorba.shotwell.preferences.files commit-metadata true"
su svc -c "gsettings set org.yorba.shotwell.preferences.files import-dir '${LIBDIR}'"


#run firefox with user
exec su svc -c "shotwell $@"
