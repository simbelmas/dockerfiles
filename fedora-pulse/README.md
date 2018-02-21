# Fedora-pulse container
Provides ifedora container with pulseaudio.

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

You can then launch it with: `docker start CONTAINER_NAME`
