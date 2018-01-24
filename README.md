# DevOps Test Case by Adilson

DevOps Test Case with Docker Compose

This is a multi-container Docker application that servers a json index.php and have others background servers. Each container has a service that is explained below.

# Requirements

* Docker and Docker Compose installed.

# Usage

Go to the proejct folder and run `docker-compose up`

# Containers

Each container will be explained below with their volumes and docker-compose.yml configurations

## haproxy

Is a load balancer for the two apache containers. Is our frontend for the json index.php and can be acessed by this address.

http://0.0.0.0:8989

You can change this port for any port at docker-compose.yml file.

There is also a stats report at http://0.0.0.0:8989/haproxystats. The default username and password are `haproxy_admin` and `haproxy_password` you can change it in your haproxy.cfg before lauching the app or inside the container.

## web_01 and web_02

They are our Apache containers. It serves a simple index.php displaying a json file and sets a session variable. The session and logging only happens when you access the haproxy container. The php interpreter is located at another container.

## fpm

Is a php-fpm 7.1 container. It interprets all php code from the Apache containers. To do that it was necessary to mount the Apache DocumentRoot volume, web_data, to access the php files. It grabs all session variables and send it to the redis server.

## redis

Is a NoSQL container that stores all sessions via php-fpm form our Apache containers. With this index.php any session expires in two hours. You can check if it stores all variables per session running this command inside the container:

`redis-cli keys '*' && echo 'keys *' | redis-cli | sed 's/^/get /' | redis-cli `

## logstash

It grabs `/var/log/apache2/access.log` and `/var/log/apache2/error.log` from the web_logs volume and send all data to the Elasticsearch container.

## elasticsearch

Process and index all Apache access and error logs received from the Logstash container.

## kibana

Allows viewing the data from the Elasticsearch container. It can be acessed directly at http://0.0.0.0:5601.

## jenkins

Is a Continuous Integration server that runs one scheduled job once per day. This script runs a series of curl commands to the Elasticsearch container that lists all Logstash and system logs with a date and remove any index older than 30 days.

One Logstash index has a name like that: `logstash-2017.12.26`. The shell script grabs the date from the end of the index name and calculates how may days is older than today. If the age value is more than 30 days old, the script will send a curl command to delete the index from the Elasticsearch container.

The Jenkins server can be acessed directly at http://0.0.0.0:8080. It was configured at build time with a username `jenkins_admin` and password `jenkins_password`. You can change this user or add more users at Jenkins  management page at http://0.0.0.0:8080/manage.

# Any other settings..

You can check any other containers and app settings checking the `docker-compose.yml` file, the `Dockerfile` inside the subfolders and any other comment inside the apps config files and scripts.

# License

It is licensed under Apache License 2.0. You can check a copy of the license in this git repository or see the footnote below.

Copyright 2018 Adilson dos Santos Dantas

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
