# timescaledb-postgis

the timescaledb-postgis image is [discontinued](https://github.com/timescale/timescaledb-docker/commit/b737865a70c824dca0fc2e7f0ce5e1d1068c8743) in the timescaledb-docker repo

the [timescale/timescaledb-ha](https://hub.docker.com/r/timescale/timescaledb-ha/tags) docker image includes postgis but has a size of **1.5gb**

the size of this [mxfactorial/timescaledb-postgis:latest](https://hub.docker.com/r/mxfactorial/timescaledb-postgis) image is approximately **268mb**

development only

dependencies:
* postgresql 16
* timescaledb 2.15.2
* postgis 3.4.2

#### build
```sh
# optional
make
```

#### run
```sh
# 1. start the container
docker run -d -p 5432:5432 --name timescaledb-postgis -e POSTGRES_PASSWORD=password mxfactorial/timescaledb-postgis:latest
# 2. print currently installed extensions
docker exec -e PGPASSWORD=password timescaledb-postgis psql -h localhost -U postgres -c "\dx;"
# 3. connect using your preferred client
```

#### clean up
```sh
docker stop timescaledb-postgis
docker rm timescaledb-postgis
docker image remove mxfactorial/timescaledb-postgis:latest
```