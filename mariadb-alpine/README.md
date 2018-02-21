#Alpine Mariadb container
Provides alpine container with mariadb server + client.
initialises an empty database when created with an empty /var/lib/mysql directory.
Mariadb listens on port 3306 and mysql user is authenticated on socker when loggued in container.

backup user and password can be provided respectively in:
* /etc/myscr/backup_usr
* /etc/myscr/backup_password