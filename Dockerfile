FROM crashvb/supervisord:202201080446@sha256:8fe6a411bea68df4b4c6c611db63c22f32c4a455254fa322f381d72340ea7226
ARG org_opencontainers_image_created=undefined
ARG org_opencontainers_image_revision=undefined
LABEL \
	org.opencontainers.image.authors="Richard Davis <crashvb@gmail.com>" \
	org.opencontainers.image.base.digest="sha256:8fe6a411bea68df4b4c6c611db63c22f32c4a455254fa322f381d72340ea7226" \
	org.opencontainers.image.base.name="crashvb/supervisord:202201080446" \
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
COPY entrypoint.mysql /etc/entrypoint.d/20mysql

# Configure: healthcheck
COPY healthcheck.mysql /etc/healthcheck.d/mysql

EXPOSE 3306/tcp

VOLUME /var/lib/mysql
