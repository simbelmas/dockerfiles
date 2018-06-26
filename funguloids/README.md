# Funguloids container
Provides funguloids container

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
