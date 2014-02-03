Vagrantfile for Docker host
====

### How to install

Change settings if you need. (e.g. IP Address)

```
$ vi ./Vagrantfile
```

This file is forked from <a href="http://fnichol.github.io/dvm/">dvm by fnichol</a>.


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
$ export DOCKER_HOST="192.168.42.43:4243"
```

Now you can run docker command in OS X.

```
$ docker ps
```
