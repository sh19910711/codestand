should() {
  grep "$@" || exit 1
}
should_not() {
  grep "$@" && exit 1
}

docker-compose exec mockup sh -c "apk add curl; curl http://gateway/builds" | should_not builds
docker-compose exec mgmt sh -c "apk add curl; curl http://gateway/builds" | should builds
