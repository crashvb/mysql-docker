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
RUN APT_ALL_REPOS=1 docker-apt mysql-server && \
	rm --force --recursive ${MYSQL_DATA}/*

# Configure: mysql
RUN install --directory --group=mysql --mode=0750 --owner=mysql /var/run/mysqld && \
	sed --in-place --expression='/^bind-address/s/127.0.0.1/0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

# Configure: supervisor
ADD supervisord.mysql.conf /etc/supervisor/conf.d/mysql.conf

# Configure: entrypoint
ADD entrypoint.mysql /etc/entrypoint.d/20mysql

EXPOSE 3306/tcp

VOLUME /var/lib/mysql
