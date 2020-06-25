# Mattermost setup

Source https://mattermost.com/download/

## Prototype Install

`docker run --name mattermost-preview -d --publish 8065:8065 mattermost/mattermost-preview`
`docker run --name mattermost-persistant -d -v datafiles:/mm/mattermost-data --publish 8064:8065 mattermost/mattermost-preview`

### Backup / Restore

Import Export for mattermost

* https://docs.mattermost.com/administration/bulk-export.html

```
#!/bin/bash

docker exec -it mattermost-preview mattermost export bulk /var/bulk_data.json --all-teams
docker cp mattermost-preview:/var/bulk_data.json ./matter_bulkchat.json
docker exec -it mattermost-preview tar cvf /var/bulkfiles.tar /mm/mattermost-data/
docker cp mattermost-preview:/var/bulkfiles.tar ./matter_bulkfiles.tar
```

* https://docs.mattermost.com/deployment/bulk-loading.html

```
#!/bin/bash

# Restore bulk files
docker cp ./matter_bulkfiles.tar mattermost-persistant:/var/bulkfiles.tar
docker exec -it mattermost-persistant mkdir /mm/mattermost-data
docker exec -it mattermost-persistant bash -c "cd / && tar -xvf /var/bulkfiles.tar"

# Restore chat
docker cp ./matter_bulkchat.json mattermost-persistant:/var/bulk_data.json
# Validate json
docker exec -it mattermost-persistant mattermost import bulk /var/bulk_data.json --validate
# Import data
docker exec -it mattermost-persistant mattermost import bulk /var/bulk_data.json --apply

```

## Production Install (Ubuntu 18.04)

```
sudo apt-get install git
git clone https://github.com/mattermost/mattermost-docker.git
cd mattermost-docker
docker-compose build
mkdir -pv ./volumes/app/mattermost/{data,logs,config,plugins,client-plugins}
chown -R 2000:2000 ./volumes/app/mattermost/
docker-compose up -d
```

### SSL

> Install with SSL certificate

> Put your SSL certificate as `./volumes/web/cert/cert.pem` and the private key that has no password as `./volumes/web/cert/key-no-password.pem`. If you don't have them you may generate a self-signed SSL certificate.
> Source https://github.com/mattermost/mattermost-docker#install-with-ssl-certificate

## Backup / Restore

Import Export for mattermost production

* https://docs.mattermost.com/administration/bulk-export.html

```
docker exec -it mattermost-docker_app_1 mattermost export bulk /var/bulk_data.json --all-teams
docker cp mattermost-docker_app_1:/var/bulk_data.json ./matter_bulkchat.json
docker exec -it mattermost-docker_app_1 tar cvf /var/bulkfiles.tar /mm/mattermost-data/
docker cp mattermost-docker_app_1:/var/bulkfiles.tar ./matter_bulkfiles.tar
```

* https://docs.mattermost.com/deployment/bulk-loading.html

```
# Restore chat
docker cp ./matter_bulk.json mattermost-docker_app_1:/var/bulk_data.json
# Validate json
docker exec -it mattermost-docker_app_1 import bulk data.json --validate
# Import data
docker exec -it mattermost-docker_app_1 import bulk data.json --apply

# Restore bulk files
docker cp ./matter_bulkfiles.json mattermost-docker_app_1:/var/bulkfiles.tar
docker exec -it mattermost-docker_app_1 tar -xvf /var/bulkfiles.tar /mm/mattermost-data
```

## Configuration

Source https://docs.mattermost.com/administration/config-settings.html

## Integration

### Plugins

* https://github.com/Amonith/mattermost-file-list/blob/master/README.md

### Push Notification

Mattermost push notifications

https://docs.mattermost.com/mobile/mobile-hpns.html

* US https://push.mattermost.com/
* DE https://hpns-de.mattermost.com/

Build my own push server

https://developers.mattermost.com/contribute/mobile/push-notifications/service/
