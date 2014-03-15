How to use Docker
====

### Installation

#### Mac OS X

Run this handy script to setup [boot2docker](https://github.com/boot2docker/boot2docker).

**WARNING: The existing boot2docker VM will be destroyed!**

```
$ cat ./profile    # customize profile if you need
$ ./setup_mac.sh
```

Then set the environment variable like this.

```
$ export DOCKER_HOST=tcp://127.0.0.1:4243
```

It's a good idea to define alias.

```
$ alias b2d=boot2docker
```


### Operations

|purpose             |command               |notes|
||
|Log in to the VM|```$ boot2docker ssh```|password: ```tcuser```|
|Check Docker version|```$ docker version```|
|Print running containers|```$ docker ps```|
|Print all containers|```$ docker ps -a```|
|Print images|```$ docker images```|

### Example

#### Running [shogi-server](https://index.docker.io/u/mogproject/shogi-server/)


**NOTE: The binding port should be in the range 49000-49900**

```
$ docker pull mogproject/shogi-server
$ docker run -d -p 49081:4081 mogproject/shogi-server
$ docker ps
```

Play now!

```
console1$ telnet localhost 49081
LOGIN user1 pass1
```

```
console2$ telnet localhost 49081
LOGIN user2 pass2
```

or ```LOGOUT``` to quit.

Stop the container. (Images and containers will not be deleted)

```
$ docker ps    # check the container id
$ docker stop <CONTAINER_ID>
```
