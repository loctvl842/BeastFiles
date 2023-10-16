# Installation

```sh
sudo pacman -S docker docker-compose
```

Start/Enable docker
```sh
sudo systemctl start/enable docker.service
```

Add current User to the Docker Group
```sh
sudo usermod -aG docker $USER
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

### External networks

Use field `external: true` for external networks. (Use when we want to connect Docker containers to a network that is created and managed outside of Docker stack, such as a network managed by the host system or a network created by a different Docker Compose project.)

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

### Clean up Docker resources (unused containers, networks, images, volumes)

- `-a`: This flag removes all unused resources, not just dangling ones. It effectively prunes all containers, networks, images, and volumes that are not currently in use by any running or stopped container. Without this flag, docker system prune would remove only dangling resources (those not associated with any container).

- `-f`: This flag is used to force the removal of resources without confirmation. When you use the -f flag, Docker will immediately proceed with the pruning operation without asking for user confirmation. Without this flag, Docker will prompt you to confirm the removal of resources.

```sh
docker system prune -af
```
