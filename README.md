# smart-package

## Prerequisites

1. Install [NodeJS](https://nodejs.org/en/download/)
2. Install [Swagger Codegen](https://swagger.io/docs/open-source-tools/swagger-codegen/)
3. Install [Python 3](https://www.python.org/downloads/)
4. Install Django
   ```bash
   python3 -m pip install Django  
   ```
5. Install Angular
   ```bash
   npm install -g @angular/cli
   ```
6. Install [Docker](https://docs.docker.com/get-docker/) -  For testing locally

## Folder Structure
1. datascience - Django based web application for ML. See [details](datascience/README.md) for setup.
2. frontend - Angular based frontend application. See [details](frontend/README.md) for setup.
3. webapi - Nodejs swagger based application. See [details](webapi/README.md) for setup.

 
## To Run
### On Docker-Compose
#### Before you build, ensure you have docker installed and you need to run these scripts:

#### 1) To build all containers
```bash
docker-compose build
```

#### 2) To run all containers(will start on port 8000(Frontend), 10010(Web API) and 8060(Data Science)):
```bash
docker-compose up
```
#### Links
 Frontend - http://127.0.0.1:8000

 Web API - http://127.0.0.1:10010

 Data Science Backend - http://127.0.0.1:8060

##### Things to note:
1. You can ignore any errors from the startup of datascience with  `sqlite3.IntegrityError: column username is not unique`, this means the database exists previously
2. Currently, things are setup to make use of your local changes in all the folders so you can easily refresh. 
    
    **Frontend**
     To ensure updates take effect on change.
     1. add the below to the frontend section of the docker compose file
        ```yaml
        volumes:
          - ./frontend/dist/frontend:/usr/share/nginx/html
        ```
     2. Each time you make a local change to the **frontend** or at first use, Run the below command in the machinelearning folder:
     ```bash
     npm build
     ```
     
3. To deploy everything using docker compose without making use of local, remove the volumes section from docker-compose.yaml

#### 4) When you want to stop all containers: (this stops your running docker containers)
```bash
docker-compose stop
```

#### 6) When you want to remove all the stopped containers (a more complete cleanup of your docker containers)
##### NOTE: this is just removing the Docker *containers* (your Docker *images* will be kept).
```bash
docker-compose rm
```

### Credentials
If you want to access the Django database, navigate to `http://127.0.0.1:8060/admin` on a browser and use the password below:

```
password - testuser
username - admin
```

### Deploying to Openshift
#### To-Do