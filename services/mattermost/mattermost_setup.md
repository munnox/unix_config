# Mattermost setup

Source https://mattermost.com/download/

## Prototype Install

`docker run --name mattermost-preview -d --publish 8065:8065 mattermost/mattermost-preview`

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

## SSL

> Install with SSL certificate

> Put your SSL certificate as `./volumes/web/cert/cert.pem` and the private key that has no password as `./volumes/web/cert/key-no-password.pem`. If you don't have them you may generate a self-signed SSL certificate.
> Source https://github.com/mattermost/mattermost-docker#install-with-ssl-certificate

## Backup / Restore

Import Export for mattermost

* https://docs.mattermost.com/administration/bulk-export.html

```
docker exec -it mattermost-preview mattermost export bulk /var/bulk_data.json --all-teams
docker cp mattermost-preview:/var/bulk_data.json ./matter_bulk.json
```

* https://docs.mattermost.com/deployment/bulk-loading.html

```
docker cp ./matter_bulk.json mattermost-preview:/var/bulk_data.json
# Validate json
docker exec -it mattermost import bulk data.jsonl --validate
# Import data
docker exec -it mattermost import bulk data.jsonl --apply
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
