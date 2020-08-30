# Author Robert Munnoch
# Start a jupyter lab using
# make lab
# then set the access password by using
# make setup


# Start a simple jupyter lab
lab:
	docker-compose up -d
# Stop the lab
stop:
	docker-compose down
# Ask the container to set a password
pass:
	docker-compose exec lab jupyter notebook password
# Restart the container system
restart:
	docker-compose restart lab
# setup the jupyter lab by setting the password and restarting the service using the targets above
setup: pass restart

# show container info
ps:
	docker-compose ps -a
