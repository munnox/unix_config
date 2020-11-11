# Docker backing up

## Volume

### Backup to tar
```
docker run  --rm -it --volume-from <container_name> -v $(pwd):/backup ubuntu tar cvf /backup/backup.tar /data
```

### Restore from tar
```
docker run --rm -it --volume-from {{ container_name }} -v ${pwd}:/backup ubuntu bash -c "cd /models && tar xvf /backup/backup.tar --strip 1"
```


