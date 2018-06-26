# Thunderbird container
Provides firefox container with fedora.

## Run in docker
```bash 
docker run -it --rm \
  --net host \
  --shm-size 1G \
  --ipc private
  -e DISPLAY=unix$DISPLAY \
  -e UID=${UID} \
  -e GID=${UID} \
  -v /home/${USER}/app_data/thunderbird/config:/home/svc/.mozilla \
  -v /home/${USER}/app_data/thunderbird/profiles:/home/svc/.thunderbird \
  -v /run/user/${UID}/pulse:/run/user/${UID}/pulse \
  -v /home/${USER}/.pulse:/home/svc/.pulse \
  -v /run/user/${UID}/pulse:/run/user/${UID}/pulse \
  -v /home/${USER}/.config/gtk-3.0/:/home/svc/.config/gtk-3.0:ro \
  -v /etc/localtime:/etc/localtime:ro
  -v /tmp/.X11-unix:/tmp/.X11-unix
  -v /dev/snd:/dev/snd
  --name thunderbird \
  simbelmas/thunderbird
  ```
## Provision with ansible then start it when you want
Use the attached *provision.yml* list of tasks to call it from your play.
You must provide:
* a var named service_user_data resulting from:
  ```yaml
  - name: Grab service user infos
    user:
      name: "YOUR_USER"
      register: service_user_data
  ```
 * a var named: container_name 
 * a optional variable extra_args passed to the docker start command

You can then launch it with: `docker start CONTAINER_NAME`
