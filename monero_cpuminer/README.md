#Imapfilter container
Provides alpine container with [imapfilter](https://github.com/lefcha/imapfilter), email filter written in lua.


To use it, pass 3 environment variables:
 * UID: user id
 * GID: user group id
 * imapfilter_parameters: parameters of imapfilter command

```
docker container run imapfilter -d \
  -v /docker/imapfilter:/imapfilter
  -e UID=1010 \
  -e GID=2010 \
  -e imapfilter_parameters -vc /imapfilter/mycnf.lua
```
