# mysql-docker

## Overview

This docker image contains [mysql](https://www.mysql.com/).

## Entrypoint Scripts

### mysql

The embedded entrypoint script is located at `/etc/entrypoint.d/20mysql` and performs the following actions:

1. A new mysql configuration is generated using the following environment variables:

 | Variable | Default Value | Description |
 | ---------| ------------- | ----------- |
 | MYSQL_ROOT_PASSWORD | _random_ | The mysql `root` password. |
 | MYSQL_DATABASE | | If defined, a database with the given name will be created. |
 | MYSQL_USER | | If defined, a user with the given name will be created. |
 | MYSQL_USER_PASSWORD | _random_ | The mysql _<user>_ password. |

## Standard Configuration

### Container Layout

```
/
├─ etc/
│  └─ entrypoint.d/
│     └─ 20mysql
├─ root/
│  ├─ mysql_root_password
│  └─ mysql_user_password
└─ var/
   └─ lib/
      └─ mysql/
```

### Exposed Ports

* `3306/tcp` - mysql listening port.

### Volumes

None.

## Development

* `/var/lib/mysql` - The mysql data directory.

[Source Control](https://github.com/crashvb/mysql-docker)

