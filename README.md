docker installation
--------------------

In order to run the simulator, docker and docker-compose are necessary.

In the case of a Windows or Mac environment, please install docker for Windows or Mac respectively.

In the case of Linux, please input the following commands and install docker.

```sh
$ curl -fsSL https://get.docker.com -o get-docker.sh
$ sh get-docker.sh
```

If you input the following command, even regular users will be able to execute the docker command.

```sh
$ sudo usermod -aG docker <ユーザ名>
```

After executing the above command, log out then log in again.

Input the following command, then verify that docker can execute correctly.

```sh
$ docker info
```

Input the following commands and install docker-compose.
As the docker-compose that can be installed via apt-get is old,
please input all of the following commands to install the newest version of docker-compose.

```sh
$ sudo apt-get remove docker-compose
$ COMPOSE_VERSION=$(wget https://api.github.com/repos/docker/compose/releases/latest -O - | grep 'tag_name' | cut -d\" -f4)
$ sudo wget https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` -O /usr/local/bin/docker-compose
$ sudo chmod 755 /usr/local/bin/docker-compose
```

Usage
------

Please input the following commands to clone this repository.

```sh
$ git clone https://github.com/hsr-project/tmc_wrs_docker.git
$ cd tmc_wrs_docker
```

Download all of the images necessary for running the simulator.
As you will be downloading a large amount of data,
please execute the following command in an environment that is connected to a high speed network.

```sh
$ ./pull-images.sh
```

Starting the simulator
----------------------

Please input the following command and start the simulator.

```sh
$ docker-compose up
```

Please open each of the following URLs in a browser, then move on to development.

- The simulator's screen http://localhost:3000
- IDE http://localhost:3001
- jupyter notebook http://localhost:3002

Starting the simulator in an environment with a GPU
---------------------------------------------------

If it is the case that there is an NVIDIA video card, then acceleration of the simulation through rendering on the GPU is possible.

First, please install nvidia-docker by referring to the following URL:

https://github.com/NVIDIA/nvidia-docker

Next, perform rendering on display number 0 of the X server that was started up on the server.
Please input the following command, to to give access from within docker to the X server.

```sh
$ DISPLAY=:0 xhost si:localuser:root
```

Please input the following command and start the simulator.

```sh
$ docker-compose -f docker-compose.nvidia.yml up
```

Please open each of the following URLs in a browser, then move on to development.

- The simulator's screen http://localhost:3000
- IDE http://localhost:3001
- jupyter notebook http://localhost:3002

Running autonomous movement
----------------------------

In gazebo in the simulator's screen, click the play button (the right facing arrow in the lower left of the screen), and start the simulation.
Into the terminal of the IDE screen, please input the following command to start rviz:

```
rviz -d $(rospack find hsrb_rosnav_config)/launch/hsrb.rviz
```

rviz will appear in the simulator's screen.
If you click "2D Nav Goal" in rviz and click the autonomous movement goal,
then the HSR will move autonomously to the goal location.

Operation within the docker host PC
-----------------------------------

In order to communicate from the host PC that is running the docker image with the simulator's roscore,
it is necessary that ROS_MASTER_URI is set appropriately.
If you source the script that is located directly under this package as illustrated below,
then it is possible to set ROS_MASTER_URI.

```sh
$ source ./set-rosmaster.sh
```

After starting the simulator, please check that ROS communication is working using the host PC.

Authors
---------------
 * Yosuke Matsusaka

Contact
---------------
 * HSR Support <xr-hsr-support@mail.toyota.co.jp>

LICENSE
---------------
This software is released under the BSD 3-Clause Clear License, see LICENSE.txt.
