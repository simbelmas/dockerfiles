#Alpine git
Provides alpine container with:
* git
* borg backup
* python kubernetes client
  
Allow builds from various archs.


podman container run -t --rm \
   quay.io/simbelmas/alpine-stress:x86_64
```
