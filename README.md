# Task for MPSI 2018 (DevOps Engineers)

## Dockerfile build

Please, clone this repository and build your Dockerfile


`git clone https://vliubko@bitbucket.org/vliubko/macpaw_docker.git vliubko_task`

`cd vliubko_task`

`docker build -t vliubko_task_image .`

## Docker container run

You can run this container with command


`docker run --rm --name vliubko_task -d -p 80:80 vliubko_task_image`

## What's happening

You can read comments in **Dockerfile** and **zip\_pass_vliubko.sh**.
