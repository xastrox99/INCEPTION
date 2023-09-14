Docker := ./srcs/docker-compose.yml

all: folders
	docker-compose -f $(Docker) up --build

folders:
	if [ ! -d "/Users/mbaazzy/data" ]; then mkdir -p /Users/mbaazzy/data /Users/mbaazzy/data/mariadb /Users/mbaazzy/data/wordpress; fi

build:
	docker-compose -f $(Docker) up -d --build

down:
	docker-compose -f $(Docker) down 

re:	down
	docker-compose -f $(Docker) up -d --build

clean: down

fclean:
	docker stop $$(docker ps -qa)
	docker system prune --all --force --volumes
	docker network prune --force
	docker volume prune --force
	rm -rf /Users/mbaazzy/data/mariadb/* /Users/mbaazzy/data/wordpress/*
	

.PHONY	: all build down re clean fclean