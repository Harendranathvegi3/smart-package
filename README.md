# smart-package

Prerequisites

1. Install NodeJS 
2. Install Swagger
2. Install Python 3
3. Install Django
4. Install Angular
5. Install Swagger Codegen https://swagger.io/docs/open-source-tools/swagger-codegen/




NodeJS

Edit Swagger
```swagger project edit```

Start Swagger
```swagger project start```

Python

```python3 manage.py runserver```

Frontend
https://www.carbondesignsystem.com/tutorial/angular/overview

https://github.com/carbon-design-system/carbon-angular-starter

```ng serve```

```swagger-codegen generate -i <path-to-swagger.json> -l <lang-code> -o <output-path>```
 
Django based application

Folder Structure

MLAlgorithms - Main folder containing Django components
machinelearning - contains frontend code
To Run

On Docker-Compose

Before you build, ensure you have docker installed and you need to run these scripts:

1) Run this once, to download the "smartpages/nuance_caller_base" and "smartpages/kubenodebase"

./RegistryLogin.sh
2) To build all containers

docker-compose build
3) To run all containers(will start on port 8060(Backend) and 3020(UI)):

docker-compose up
Links

Frontend - http://127.0.0.1:3020 Backend - http://127.0.0.1:8060

Things to note:

You can ignore any errors from the startup of mlbackend with sqlite3.IntegrityError: column username is not unique, this means the database exists previously

Currently, things are setup to make use of your local changes in the frontend and backend so you can easily refresh.

Frontend

Each time you make a local change to the frontend or at first use, Run the below command in the machinelearning folder:

npm build
To deploy everything full using docker compose without making use of local:

Uncomment all the commented lines (7,10, 17, 19) in machinelearning/Dockerfile.
Navigate into machinelearning/nginx/default.conf, replace line 20 with root /usr/share/nginx/html.
Also remove the volumes section from docker-compose.yaml
Backend Each time a change is made, you'll notice the worker of that component reboot. To deploy everything full using docker compose without making use of local:

Remove the volumes section from the mlbackend service
4) When you want to stop all containers: (this stops your running docker containers)

docker-compose stop
6) When you want to remove all the stopped containers (a more complete cleanup of your docker containers)

NOTE: this is just removing the Docker containers (your Docker images will be kept).

docker-compose rm
Credentials

If you want to access the Django database, navigate to http://127.0.0.1:8060/admin on a browser and use the password below:

password - Q3Enhancements
username=admin