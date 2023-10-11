# Installation

```sh
sudo pacman -S docker docker-compose
```

# Docker Commands, Help & Tips

### Attach to a Running Container:
If a container is already running, attach to it.

```sh
docker exec -it container_name_or_id /bin/bash
```

### Create a new network

```sh
docker network create --driver bridge network_name
```

### Connect a container to a network

```sh
docker network connect network_name container_name
```

### List all container_id

```sh
docker ps -a -q
```

Stop all containers
```sh
docker stop $(docker ps -a -q)
```
