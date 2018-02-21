#Imapfilter container
Provides alpine container with [imapfilter](https://github.com/lefcha/imapfilter), email filter written in lua.


Imapfilter run rootless with user 1001 and the following directory structure is defined to allow mounting secrets/configs:
```
/imapfilter
/imapfilter/creds
/imapfilter/config
```

By default, imapfilter tries to load /imapfilter/creds/creds.lua then /imapfilter/config.config.lua that should be mounted into container.

Sample run :
```
podman container run -t --rm \
   -v ./sample/creds.lua:/imapfilter/creds/creds.lua \
   -v ./sample/rules.lua:/imapfilter/rules/rules.lua \
   -v ./sample/imapInteractive.lua:/imapfilter/config/config.lua \
   quay.io/simbelmas/imapfilter
```
