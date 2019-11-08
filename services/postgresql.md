# Postgresql

## Running

### Docker

Minimal Footprint
```
docker run --name psql -p 5432:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=mysecretpassword -d postgres:12
```

With storage folder for persistance
```
mkdir -p ./psql/datadir/
docker run --name psql -v ./psql/datadir:/var/lib/postgresql/data -d postgres:12
docker run --name psql -p 5432:5432 -v ./psql/datadir:/var/lib/postgresql/data -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=mysecretpassword -d postgres:12
```

with PGAdmin [source](https://hub.docker.com/r/dpage/pgadmin4/)

```
docker run -p 80:80 -e "PGADMIN_DEFAULT_EMAIL=user@domain.com" -e "PGADMIN_DEFAULT_PASSWORD=mysecretpassword" -d dpage/pgadmin4:4.14
```

Docker-Compose

```
# Use postgres/example user/password credentials
version: '3.1'

services:

  db:
    image: postgres:12
    restart: always
    ports:
      - 5432:5432
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: example

  pgadmin:
    image: dpage/pgadmin4:4.14
    restart: always
    ports:
      - 8080:80
    environment:
      PGADMIN_DEFAULT_EMAIL: user@domain.com
      PGADMIN_DEFAULT_PASSWORD: example

```