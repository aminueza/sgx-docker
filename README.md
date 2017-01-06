# SGX DOCKER PATCHES

This is a Git repository for Intel SGX applications using docker containers.

## Download Docker Image

1 - Sign in your docker account:

```bash
$ docker login
```
*or create a new user:

```bash
$ https://hub.docker.com
```
*or use an existing user:

```bash
$ login: aminueza
$ password: ***request password***
```

2 - Download a docker image:

```bash
$ docker pull aminueza/docker-sgx
```

## Download Dockerfile

```bash
$ git clone https://git.lsd.ufcg.edu.br/secure-cloud/sgx-apps.git sgx-docker
$ cd sgx-docker
$ git checkout sgx-docker
$ rm -rf 00*.patch
```

## Build a new docker image

3 - Build a new image:

```bash
$ docker build -t <image name> <destination-dir>
```

i.e: "docker build -t app-sgx ."

4 - Run a new image:

```bash
$ docker run --device=/dev/isgx -it <image name>
```

i.e: "docker run --device=/dev/isgx -it app-sgx"

*or start an interactive bash session:

```bash
$ docker run --device=/dev/isgx -it <image name> /bin/bash
```
