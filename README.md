# mysql-docker

[![version)](https://img.shields.io/docker/v/crashvb/mysql/latest)](https://hub.docker.com/repository/docker/crashvb/mysql)
[![image size](https://img.shields.io/docker/image-size/crashvb/mysql/latest)](https://hub.docker.com/repository/docker/crashvb/mysql)
[![linting](https://img.shields.io/badge/linting-hadolint-yellow)](https://github.com/hadolint/hadolint)
[![license](https://img.shields.io/github/license/crashvb/mysql-docker.svg)](https://github.com/crashvb/mysql-docker/blob/master/LICENSE.md)

## Overview

This docker image contains [mysql](https://www.mysql.com/).

## Entrypoint Scripts

### mysql

The embedded entrypoint script is located at `/etc/entrypoint.d/mysql` and performs the following actions:

1. A new mysql configuration is generated using the following environment variables:

 | Variable | Default Value | Description |
 | ---------| ------------- | ----------- |
 | MYSQL\_ALLOW\_INSECURE\_ROOT | | If defined, TLS will not be required for secure connection from root. |
 | MYSQL\_ALLOW\_INSECURE\_USER | | If defined, TLS will not be required for secure connection from _<user>_. |
 | MYSQL\_DATABASE | | If defined, a database with the given name will be created. |
 | MYSQL\_ROOT\_PASSWORD | _random_ | The mariadb `root` password. |
 | MYSQL\_TLS\_CIPHERSUITES | TLS\_AES\_256\_GCM\_SHA384 | The TLS cipher(s) to use for secure connections. |
 | MYSQL\_TLS\_VERSION | TLSv1.3 | The TLS versions to use for secure connections. |
 | MYSQL\_USER | | If defined, a user with the given name will be created. |
 | MYSQL\_USER\_PASSWORD | _random_ | The mariadb _<user>_ password. |

## Standard Configuration

### Container Layout

```
/
├─ etc/
│  ├─ entrypoint.d/
│  │  └─ mysql
│  ├─ healthcheck.d/
│  │  └─ mysql
│  ├─ mysql/
│  └─ supervisor/
│     └─ config.d/
│        └─ mysql.conf
├─ run/
│  └─ secrets/
│     ├─ mysql.crt
│     ├─ mysql.key
│     ├─ mysqlca.crt
│     ├─ mysql_root_password
│     └─ mysql_user_password
├─ usr/
│  └─ local/
│     └─ bin/
│        ├─ mysql-backup
│        └─ mysql-restore
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

