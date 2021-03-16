#Mosquitto container
Provides alpine container with mosquitto mqtt broker.


Mosquitto runs as user 1001 and the following directory structure is defined to allow mounting secrets/configs:
```
/mosquitto
/mosquitto/mosquitto.cfg
```
