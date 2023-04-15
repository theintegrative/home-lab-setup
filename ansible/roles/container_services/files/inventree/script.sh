docker volume rm -f inventree-production_inventree_data
docker-compose run inventree-server invoke update
docker-compose up -d

