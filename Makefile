DCOMPOSE_FILE=./srcs/docker-compose.yml
ENV_FILE=./srcs/.env
DOMAIN_USER = lprates
WORDPRESS_VOLUME_DIR=/home/${DOMAIN_USER}/data/wordpress_volume
MARIADB_VOLUME_DIR=/home/${DOMAIN_USER}/data/mariadb_volume
NGINX_LOGS=/home/${DOMAIN_USER}/data/logs/nginx
TOOLS = ./srcs/requirements/tools

all:	persistent_storage
	@docker compose -f $(DCOMPOSE_FILE) --env-file $(ENV_FILE) up -d
	@sudo sed -i '/42.fr/d' /etc/hosts
	@chmod +x $(TOOLS)/hosts.sh
	@$(TOOLS)/hosts.sh $(DOMAIN_USER)

clean:
	@docker compose -f $(DCOMPOSE_FILE) --env-file $(ENV_FILE) down
	@sudo sed -i '/42.fr/d' /etc/hosts

fclean: clean
	@sudo rm -rf $(MARIADB_VOLUME_DIR)
	@sudo rm -rf $(WORDPRESS_VOLUME_DIR)
	@sudo rm -rf $(NGINX_LOGS)
	@sudo sed -i '/42.fr/d' /etc/hosts
	@docker image prune -a -f
	@docker system prune -a

re: fclean all

persistent_storage:
	@sudo mkdir -pv $(MARIADB_VOLUME_DIR)
	@sudo mkdir -pv $(WORDPRESS_VOLUME_DIR)
	@sudo mkdir -pv $(NGINX_LOGS)

.PHONY: all fclean clean persistent_storage
