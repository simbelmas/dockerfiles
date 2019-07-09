#Imapfilter container
Provides alpine container with [imapfilter](https://github.com/lefcha/imapfilter), email filter written in lua.


To use it, pass 3 environment variables:
 * UID: user id
 * GID: user group id
 * imapfilter_parameters: parameters of imapfilter command

```
docker container run -it --name imapfilter -d \
   -v $(readlink -m .):/imapfilter \
   -e UID=${UID} \
   -e GID=${GID} \
   -e imapfilter_parameters='-vc /imapfilter/sample_config.lua' \
   imapfilter
```
