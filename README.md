Codestand
=========

Quickstart
----------

```
$ docker-compose up
```

Docker Host (Example)
---------------------

### Setup with ansible

```bash
$ create an instance on aws or somewhere else
$ cat ~/.ansible/hosts
my-instance
$ ansible-playbook -i ~/.ansible/hosts ./dockerhost/playbook.yml
```

### Deploy to docker host

```bash
$ ssh -L localhost:2375:localhost:2375 my-instance & (background)
$ export DOCKER_HOST=tcp://localhost:2375
$ ./script/deploy_via_docker.sh
```

License
-------
MIT
