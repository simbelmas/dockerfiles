# Firefox container
Provides firefox container with fedora.

## Run in podman
```bash 
    podman container run \
      --privileged \
      --rm \
      --env DISPLAY=${DISPLAY} \
      --volume "/home/user/.config/gtk-3.0/:/root/.config/gtk-3.0:ro" \
      --volume "/home/user/Downloads:/root/Downloads" \
      --volume /etc/localtime:/etc/localtime:ro \
      --volume /tmp/.X11-unix:/tmp/.X11-unix \
      --name tor-browser \
      simbelmas/tor-browser
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

You can then launch it with: `CONTAINER_NAME`
