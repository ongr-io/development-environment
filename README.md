![](https://avatars2.githubusercontent.com/u/8971056?v=3&s=150)

ONGR development environment
============

# Hey there

Are you tired from Vagrant, virtual machines (Virtualbox, VMware), MAMP, WAMP or whatever is slow and complex to maintain? 
Then you my friend are in the right place. Introducing you one file* development environment which works on every OS**.

> *we do not consider empty directory as a file. 

> **Windows lacks interactive shell support to what's happening when you execute cli commands. 

# What' inside?
After up and running you will get:
- PHP FPM 7.0
- Maria DB 10.1
- Ngnix
- Elasticsearch 2.4
- You name it..

> That said, you can add any container to the `docker-compose.yml` you want.
 Or modify by creating a build, more about it read at extending the environment topic below. 

# Start and run

## You need a Docker

We'll gonna use docker. Check out the latest version from [official website][1] according to your
 operating system. By the way, your machine should support Hyper-V to work with docker.

After you install it, you should be able to access CLI `docker` and `docker-compose` command.
 `docker-compose` is the command what we are going to use here.

> Docker pulls images via Git, so make sure you also have Git installed.

## Start the engine

The environment is designed that you can paste the content's of this repo to
the Symfony project root and you are good to go. 

> If you want just give a test drive, create a `web` directory and `app_dev.php` file
 inside it. This is the file where predefined vhost points to. 


All right, enough waiting, let's run some commands:


```bash

docker-compose up -d

```

> `-d` means you starting all containers in the background. 

## How to run `composer install`

`ongr/php-fpm` comes with pre-installed container so this container is responsible for this execution.
To pass any command run in the container execute it with `docker-compose exec`:

```
docker-compose exec fpm composer install
```

> There is `docker-compose run` command, the difference is that this command
 creates new additional container and executes command in it.

## Can I access bash in the container?

Yes. Simply run:

```
docker-compose exec fpm bash
```

And you will land in the specific container bash with root permissions. 


### Troubleshooting

If something happened first thing to do is to check logs:

```
docker-compose logs
```

Don't forget that you can check specific container logs as well

```
docker-compose logs mariadb
```

### Feedback

We always trying to improve our tools and bundles. So the feedback
is very important for us to make everything what we are creating better.
If something does'nt work as expected or you have any issues that you
don't know how to solve, please create an issue. 


[1]: https://www.docker.com/products/overview#/install_the_platform
