VOLUME_DIRECTORY=/home/mdanish/data

all: inception

inception:
	@mkdir -p ${VOLUME_DIRECTORY}/mariadb
	@mkdir -p ${VOLUME_DIRECTORY}/wordpress
	@echo Firing up the containers
	@docker compose -f ./srcs/docker-compose.yml up --build -d

clean:
	@echo Shutting down the containers
	@docker compose -f ./srcs/docker-compose.yml down --remove-orphans 2> /dev/null

fclean: clean
	@echo Removing the images
	@docker rmi `docker images -aq` > /dev/null
	@echo Removing the volumes
	@sudo rm -rf ${VOLUME_DIRECTORY}
	@docker volume rm `docker volume ls -q` > /dev/null
	@docker volume prune -f

re: fclean all

.PHONY: all, clean, fclean, re, inception