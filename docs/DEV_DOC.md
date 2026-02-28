# Dependencies:
make
docker

# Configuration
## Nginx
### Dockerfile
- install openssl
- generate rs key
- start nginx server
### Configuration
- listen on port 443 with SSL enabled
- define server name
- configure SSL certificates and allowed TLS versions
- set the root directory to the WordPress installation
- use try_files to serve static files or fallback to index.php (WordPress routing)
- forward PHP requests to PHP-FPM using FastCGI
- pass necessary HTTPS and script parameters to PHP

## Wordpress
### Dockerfile
- install php (all worpress' core logic is written in php)
- start init script
- start php-fpm server
### Init script
- download wordpress tarball which contians all core files
- make it so php cgi listens on all interfaces
## Mariadb
### Dockerfile
- create sql daemon directory and set permissions
- start init script
### Init script
- set database configurations
- start database serverr

# Launch
"make"

# Commands
## Docker
docker ps
docker logs <container_name>
docker inspect <container|volume|image>
docker volume ls
docker images
docker exec -it <container_name> sh
docker rm -f $(docker ps -q)
## Mariadb
docker exec -it mariadb mariadb -u root -p
show databases;
use <database_name>;
show tables;
describe <table>;
### Query examples
#### users
SELECT ID, user_login, user_email FROM wp_users;
#### posts
SELECT ID, post_title, post_status FROM wp_posts;
#### url
SELECT option_name, option_value 
FROM wp_options 
WHERE option_name IN ('siteurl','home');

# Data
data should be stored at:
- /home/$USER/data
