#!/bin/bash

docker exec -it mattermost-preview mattermost export bulk /var/bulk_data.json --all-teams
docker cp mattermost-preview:/var/bulk_data.json ./matter_bulkchat.json
docker exec -it mattermost-preview tar cvf /var/bulkfiles.tar /mm/mattermost-data/
docker cp mattermost-preview:/var/bulkfiles.tar ./matter_bulkfiles.tar
