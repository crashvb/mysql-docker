FROM crashvb/supervisord:202303031721@sha256:6ff97eeb4fbabda4238c8182076fdbd8302f4df15174216c8f9483f70f163b68
ARG org_opencontainers_image_created=undefined
ARG org_opencontainers_image_revision=undefined
LABEL \
	org.opencontainers.image.authors="Richard Davis <crashvb@gmail.com>" \
	org.opencontainers.image.base.digest="sha256:6ff97eeb4fbabda4238c8182076fdbd8302f4df15174216c8f9483f70f163b68" \
	org.opencontainers.image.base.name="crashvb/supervisord:202303031721" \
	org.opencontainers.image.created="${org_opencontainers_image_created}" \
	org.opencontainers.image.description="Image containing mysql." \
	org.opencontainers.image.licenses="Apache-2.0" \
	org.opencontainers.image.source="https://github.com/crashvb/mysql-docker" \
	org.opencontainers.image.revision="${org_opencontainers_image_revision}" \
	org.opencontainers.image.title="crashvb/mysql" \
	org.opencontainers.image.url="https://github.com/crashvb/mysql-docker"

# Install packages, download files ...
ENV MYSQL_DATA=/var/lib/mysql
RUN APT_ALL_REPOS=1 docker-apt mysql-server ssl-cert && \
	rm --force --recursive ${MYSQL_DATA:?}/*

# Configure: mysql
RUN usermod --append --groups ssl-cert mysql && \
	install --directory --group=mysql --mode=0750 --owner=mysql /var/run/mysqld && \
	sed --expression="/^bind-address/s/127.0.0.1/0.0.0.0/" \
		--expression="/# ssl-ca=/cssl-ca = /etc/ssl/certs/mysqlca.crt" \
		--expression="/# ssl-cert=/cssl-cert = /etc/ssl/certs/mysql.crt" \
		--expression="/# ssl-key=/cssl-key = /etc/ssl/private/mysql.key\nrequire_secure_transport = ON" \
		--in-place=.dist /etc/mysql/mysql.conf.d/mysqld.cnf

# Configure: supervisor
COPY supervisord.mysql.conf /etc/supervisor/conf.d/mysql.conf

# Configure: entrypoint
COPY entrypoint.mysql /etc/entrypoint.d/mysql

# Configure: healthcheck
COPY healthcheck.mysql /etc/healthcheck.d/mysql

EXPOSE 3306/tcp

VOLUME ${MYSQL_DATA}
