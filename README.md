<a name="top"></a>
<div style="float:right"> 

![Thanos](./docs/img/thumb-201102.jpg)

 </div>

# Docker Volumes
A Docker volume is a directory (or collection of files) that lives on the host file system and is not a part of the container’s UFS. It is within these volumes that containers are capable of saving data. With the docker volume command, you can easily manage volumes to expand your containers well beyond their basic capability.

Let’s find out how to deploy a new container that includes a volume attached to a specific directory on a host such that the container will stay in sync with the data in the volume. I will assume you already have Docker up and running and can deploy containers.

## Table of contents
* [Creating the Host Data Volume](#creating-the-host-data-volume)
* [Technologies](#technologies)

---

<div style="float:right"> 

[top](#top)

 </div>
	
## Creating the Host Data Volume
Create a new directory to house the volume. Open a terminal window and issue the command:

```Powershell
mkdir ~/container-data
```

Once you’ve created that directory, you’re ready to mount a volume inside. Let’s say you’re going to deploy a container, based on the official Ubuntu image, that contains a directory called /data. To deploy such a container that attaches the internal /data directory to a volume within the host directory ~/container-data, you would issue the command:

```Powershell
docker run -dit -P --name ubuntu-test -v ~/container-data:/data ubuntu
```

<!--
ed68de38675
-->

The above command breaks down like this:

* _docker run_ is the main command that says we’re going to run a command in a new container.
* -dit is d for detached mode, and it ensures that bash or sh can be allocated to a pseudo terminal.
* -P publishes the containers ports to the host.
* –name says what follows is the name of the new container.
* -v says what follows is to be the volume.
* ubuntu is the image to be used for the container.

Once the command completes, you will be given a container ID (Figure A). Make sure to remember the first four characters of that ID, as you’ll need it to gain access to the container bash prompt.

---

<div style="float:right"> 

[top](#top)

 </div>
	

## Testing the Volume
Let’s test this volume. If you’ve forgotten the ID of the container, issue the following command to see it listed

```Powershell
docker ps -a
```

Access the newly-deployed container with the command:

```Powershell
docker attach <IMAGE_ID>
```


Where ID is the first four characters of the deployed container. You should now find yourself at the bash prompt within the container. Issue the command ls / and you will see the /data directory added to the Ubuntu container.

>
>**myuser@mymachine:**~/projects/docker-volumes$ docker attach ed68de38675
<br />
>**_root@ed68de38675e:_**/# ls

![image directories](./docs/img/img1.jpg)

Let’s create a test file in that directory with the command:

>**_root@ed68de38675e:_**/# **touch** /data/test

After creating this test file, _open another terminal window_ on the host machine and issue the command ls ~/container-data. You should see the test file within that directory

>**myuser@mymachine:** \~\$ cd ~/container-data <br />
>**myuser@mymachine:** ~/container-data$ ls <br />
_testfile_ <br />
>**myuser@mymachine:**~/container-data$ <br />
>

You’ve just deployed a container that includes persistent storage, via a volume on the host.

---
 
<div style="float:right"> 

[top](#top)

 </div>
	

## Database Volume

---

<div style="float:right"> 

[top](#top)

 </div>

### Manually Add Named Volume

>**myuser@mymachine:**~/projects/docker-volumes$ docker volume create mysql-test <br />
mysql-test <br />
>**myuser@mymachine:**~/projects/docker-volumes$ docker volume list <br />
DRIVER    VOLUME NAME <br />
local     mysql-test <br />
local     vscode <br />
>**myuser@mymachine:**~/projects/docker-volumes$ docker volume inspect mysql-test  
 [
 <br />        {
 <br />            "CreatedAt": "2021-10-25T20:15:19Z",
 <br />            "Driver": "local",
 <br />            "Labels": {},
 <br />            "Mountpoint": "/var/lib/docker/volumes/mysql-test/_data",
 <br />            "Name": "mysql-test",
 <br />            "Options": {},
 <br />            "Scope": "local"
 <br />        }
 <br />    ]  <br />
>**myuser@mymachine:**~/projects/docker-volumes$ docker volume rm mysql-test <br /> 
mysql-test <br /> 
>**myuser@mymachine:**~/projects/docker-volumes$ docker volume list <br /> 
DRIVER    VOLUME NAME  <br /> 
local     vscode <br /> 


### Create Image for MySQL with Named Volume
Let’s say you want to create a volume for a database. You can do this by first deploying a MySQL database Docker container and instructing it to use a persistent storage volume named mysql-data. Do this with the command:

```bash

docker run --name mysql-test -v mysql-data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=passwd -d mysql:latest

```

In the above command, the -e switch informs docker what follows is an environment variable.

Access the bash prompt for the container with the command:


```bash

docker exec -it <IMAGE_ID> /bin/bash

```

List out the contents of the container’s /var/lib/mysql directory with the command:


```bash

ls /var/lib/mysql

```

Make note of those contents and exit from the container with the command:


```bash

exit

```

Now, check the contents of the host’s mounted volume with the command:

```bash

sudo ls /var/lib/docker/volumes/mysql-data/_data

```

You should see the listing in both directories is the same 