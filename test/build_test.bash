should() {
  grep "$@" || exit 1
}

should_not() {
  grep "$@" && exit 1
}

docker-compose exec mockup apk add curl
docker-compose exec mockup curl http://gateway/build/builds | should_not builds
docker-compose exec mockup curl http://gateway/build/builds | should "403 Forbidden"
docker-compose exec mgmt apk add curl
docker-compose exec mgmt curl http://gateway/build/builds | should builds
