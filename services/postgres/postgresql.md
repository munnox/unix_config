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
    restart: unless-stopped
    ports:
      - 5432:5432
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: example

  pgadmin:
    image: dpage/pgadmin4:4.25
    restart: unless-stopped
    ports:
      - 8080:80
    environment:
      PGADMIN_DEFAULT_EMAIL: user@domain.com
      PGADMIN_DEFAULT_PASSWORD: example

```

## Backup

```
pg_dump --host localhost --port 5432 --username postgres --format plain --ignore-version --verbose --file "<abstract_file_path>" --table public.tablename dbname
```

issues with large tables 34+GB

also recording this `nohup ./postages_dumpdb &`
