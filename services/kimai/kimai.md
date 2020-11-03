# Kimai

Time tracking software

https://www.kimai.org/documentation/docker.html

```
docker run -ti -p 8001:8001 --name kimai2 --rm kimai/kimai2:dev
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' kimai2
```


