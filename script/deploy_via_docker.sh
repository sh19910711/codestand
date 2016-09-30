#!/bin/sh

# ssh -L localhost:12345:localhost:12345 remotehost
# DOCKER_HOST=tcp://localhost:12345 ./deploy.sh

dc_exec() {
  local name=$1; shift
  echo "$name> $@"
  docker-compose exec $name $@
}

docker-compose build && docker-compose up --remove-orphans -d || exit 1
dc_exec gateway /usr/local/sbin/nginx -t -c /etc/nginx/nginx.conf || exit 1
dc_exec mgmt bundle exec rails db:migrate || exit 1
dc_exec mockup bundle exec rake db:init || exit 1
