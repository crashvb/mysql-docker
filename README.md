# mysql-docker

[![version)](https://img.shields.io/docker/v/crashvb/mysql/latest)](https://hub.docker.com/repository/docker/crashvb/mysql)
[![image size](https://img.shields.io/docker/image-size/crashvb/mysql/latest)](https://hub.docker.com/repository/docker/crashvb/mysql)
[![linting](https://img.shields.io/badge/linting-hadolint-yellow)](https://github.com/hadolint/hadolint)
[![license](https://img.shields.io/github/license/crashvb/mysql-docker.svg)](https://github.com/crashvb/mysql-docker/blob/master/LICENSE.md)

## Overview

This docker image contains [mysql](https://www.mysql.com/).

## Entrypoint Scripts

### mysql

The embedded entrypoint script is located at `/etc/entrypoint.d/20mysql` and performs the following actions:

1. A new mysql configuration is generated using the following environment variables:

 | Variable | Default Value | Description |
 | ---------| ------------- | ----------- |
 | MYSQL\_ROOT\_PASSWORD | _random_ | The mysql `root` password. |
 | MYSQL\_DATABASE | | If defined, a database with the given name will be created. |
 | MYSQL\_USER | | If defined, a user with the given name will be created. |
 | MYSQL\_USER\_PASSWORD | _random_ | The mysql _<user>_ password. |

## Standard Configuration

### Container Layout

```
/
├─ etc/
│  └─ entrypoint.d/
│     └─ 20mysql
├─ run/
│  └─ secrets/
│     ├─ mysql.crt
│     ├─ mysql.key
│     ├─ mysqlca.crt
│     ├─ mysql_root_password
│     └─ mysql_user_password
└─ var/
   └─ lib/
      └─ mysql/
```

### Exposed Ports

* `3306/tcp` - mysql listening port.

### Volumes

* `/var/lib/mysql` - The mysql data directory.

## Development

[Source Control](https://github.com/crashvb/mysql-docker)

