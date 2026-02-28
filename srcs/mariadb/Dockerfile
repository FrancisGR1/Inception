FROM alpine:3.22

# install mariadb
RUN apk add --no-cache \
	    vim \
	    mariadb \
	    mariadb-client \
	    mariadb-server-utils \
	    pwgen

# create default directories
RUN mkdir -p /run/mysqld \
&& chown -R mysql:mysql /run/mysqld /var/lib/mysql

COPY init-db.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init-db.sh

ENTRYPOINT ["/usr/local/bin/init-db.sh"]
