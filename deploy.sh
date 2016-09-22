#!/bin/sh

# Usage (recommend)
# $ ssh -L localhost:12345:localhost:12345 target-server
# $ DOCKER_HOST=tcp://localhost:12345 ./deploy.sh

docker-compose build && docker-compose up --remove-orphans -d
docker-compose exec mgmt bundle exec rails db:migrate
