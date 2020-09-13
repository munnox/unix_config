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

# Then you need to reset the password of the user to login agian

docker exec -it mattermost-persistant mattermost user password robert password
