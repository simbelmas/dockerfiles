#!/bin/ash -e
#fill UID/GID variables if not defined
if [ -z "${UID}" ] ; then
  UID=0
fi
if [ -z "${GID}" ] ; then
  GID=${UID}
fi

export UID=${UID}
export GID=${GID}

#create user
if [ -z "$(awk -F':' '$3 == "'${UID}'" {print $3}' /etc/passwd)" ] ; then
  (
    set -x
    adduser -D -u ${UID} svc
  )
fi
#create group
if [ -z "$(awk -F ':' '$3 == "'${GID}'" {print $3}' /etc/group)" ] ; then
  (
    set -x
    addgroup -g ${GID} svcg
    adduser svc svcg
  )
fi

# run app
if [ -z "$(grep 'svc:' /etc/passwd)" ] ; then
    "$@"
else
    "$@"
fi
