DATA=$(HOME)/data/
BACKUP=$(HOME)/backup/
DEBUG_BUILD = --verbose
ENV_VARS=$(HOME)/secrets/.env
DOCKER_COMPOSE = docker compose -f srcs/docker-compose.yml --env-file $(ENV_VARS)

NGINX_FILES = \
	    srcs/nginx/Dockerfile \
	    srcs/nginx/nginx.conf

MARIADB_FILES = \
	    srcs/mariadb/Dockerfile \
	    srcs/mariadb/init-db.sh
WORDPRESS_FILES = \
	    srcs/wordpress/Dockerfile \
	    srcs/wordpress/init-wp-content.sh

.PHONY: all mariadb wordpress build clean fclean re debug

all: nginx mariadb wordpress
	mkdir -p $(DATA)/mariadb
	mkdir -p $(DATA)/wordpress
	$(DOCKER_COMPOSE) up -d

nginx: $(NGINX_FILES)
	@echo "***BUILDING NGINX***"
	$(DOCKER_COMPOSE) build nginx

mariadb: $(MARIADB_FILES)
	@echo "***BUILDING MARIADB***"
	$(DOCKER_COMPOSE) build mariadb

wordpress: $(WORDPRESS_FILES)
	@echo "***BUILDING WORDPRESS***"
	$(DOCKER_COMPOSE) build wordpress

nocache:
	$(DOCKER_COMPOSE) build --no-cache

clean:
	$(DOCKER_COMPOSE) down

fclean: clean
	$(DOCKER_COMPOSE) down --rmi local

vclean:
	$(DOCKER_COMPOSE) down -v

re: fclean nocache all

logs:
	$(DOCKER_COMPOSE) logs

backup: # user needs to be in sudo group
	mkdir -p $(DATA)
	mkdir -p $(BACKUP)
	sudo rsync -avr $(DATA) $(BACKUP)

debug:
	@watch -n 1 '\
		clear; \
		echo "==================== DOCKER PS ===================="; \
		docker ps; \
		echo; \
		echo "==================== NGINX LOGS ===================="; \
		docker logs --tail=20 nginx; \
		echo; \
		echo "================== WORDPRESS LOGS =================="; \
		docker logs --tail=20 wordpress; \
		echo; \
		echo "=================== MARIADB LOGS ==================="; \
		docker logs --tail=20 mariadb; \
		'
