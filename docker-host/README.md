Vagrantfile for Docker host
====

### How to install

Change settings if you need. (e.g. IP Address)

```
$ vi ./Vagrantfile
```

Build up the virtual machine.

```
$ ./build.sh
```

### Using Docker Client

#### Mac OS X

repo: https://github.com/tcnksm/docker-osx

Install Docker Client.

```
$ sudo brew update
$ sudo brew tap homebrew/binary
$ brew install docker
```

Set environment variable.

```
$ export DOCKER_HOST="192.168.33.99:5422"
```

Now you can run docker command in OS X.

```
$ docker ps
```
