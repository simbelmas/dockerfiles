#Stress
Provides ubuntu container with stress-ng
  
~~~
podman container run -t --rm \
   quay.io/simbelmas/stress-ng:stable stress-ng --fork 4
~~~
