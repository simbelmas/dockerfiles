#!/bin/zsh -e
if [ ! -e /app/hugosource/.git ] ; then
    if [ -z "${HUGO_GIT_URL}" ] ; then
        echo "'HUGO_GIT_URL' env var must be set in order to pull hugo source from git." >&2
        exit 2
    fi
    git clone "${HUGO_GIT_URL}" /app/hugosource
    cd /app/hugosource
else
    cd /app/hugosource
    git pull
fi

exec /usr/bin/hugo --gc --destination /var/www/html --cleanDestinationDir