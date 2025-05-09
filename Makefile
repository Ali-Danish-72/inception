VOLUME_DIRECTORY=./data

all: inception

inception:
	mkdir -p ${VOLUME_DIRECTORY}/mariadb
	mkdir -p ${VOLUME_DIRECTORY}/wordpress
	docker compose -f ./srcs/docker-compose.yml up --build -d

clean:
	docker compose -f ./srcs/docker-compose.yml down --remove-orphans 2> /dev/null || true

fclean: clean
	sudo rm -rf ${VOLUME_DIRECTORY}
	docker rmi $$(docker images -aq) 2> /dev/null || true
	docker volume prune -f

re: fclean all

.PHONY: all, clean, fclean, re, inception