# pgadmin

docker source https://www.pgadmin.org/docs/pgadmin4/latest/container_deployment.html

```
docker pull dpage/pgadmin4
docker run -p 443:443 \
    -v /private/var/lib/pgadmin:/var/lib/pgadmin \
    -v /path/to/certificate.cert:/certs/server.cert \
    -v /path/to/certificate.key:/certs/server.key \
    -v /tmp/servers.json:/pgadmin4/servers.json \
    -e 'PGADMIN_DEFAULT_EMAIL=user@domain.com' \
    -e 'PGADMIN_DEFAULT_PASSWORD=SuperSecret' \
    -e 'PGADMIN_ENABLE_TLS=True' \
    -d dpage/pgadmin4
```

docker-compose

```

version: "3.1"

networks:
  pg:
    external: false

services:

  db:
    image: postgres:9.6
    restart: unless-stopped
    environment:
      - POSTGRES_USER=pguser
      - POSTGRES_PASSWORD=SuperSecret
      - POSTGRES_DB=base
    ports:
      - "5678:5678"
    networks:
      - pg
    volumes:
      - "./data/:/var/lib/postgresql/data"
      - "./initdb/:/docker-entrypoint-initdb.d"

  pgadmin:
    image: dpage/pgadmin4:4.25
    restart: unless-stopped
    ports:
      - "8000:80"
    networks:
      - pg
    environment:
      - PGADMIN_DEFAULT_EMAIL=user@domain.com
      - PGADMIN_DEFAULT_PASSWORD=SuperSecret
      # - PGADMIN_CONFIG_ENHANCED_COOKIE_PROTECTION=True
      # - PGADMIN_CONFIG_LOGIN_BANNER="Authorised users only!"
      # - PGADMIN_CONFIG_CONSOLE_LOG_LEVEL=10
      # - PGADMIN_ENABLE_TLS=True
    # volumes:
      # - ./pgadmin:/var/lib/pgadmin
      # - ./certificate.cert:/certs/server.cert
      # - ./certificate.key:/certs/server.key
      # - ./servers.json:/pgadmin4/servers.json
```
