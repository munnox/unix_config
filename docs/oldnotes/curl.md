# Info on CURL

Sources:

* https://curl.haxx.se/

## Examples

**From https://www.keycdn.com/support/popular-curl-examples**

Get `curl https://www.keycdn.com`

Headers only `curl -I https://www.keycdn.com`

Save as `curl -o myfile.css https://cdn.keycdn.com/css/animate.min.css`

Extra header `curl -H "X-Header: value" https://www.keycdn.com`

Resume download with `-C -` e.g. `curl -C - -O https://cdn.keycdn.com/img/cdn-stats.png`

**From https://mkyong.com/spring/curl-post-request-examples/**

Post `curl -X POST http://localhost:8080/api/login/`

Post with url encoded data `$ curl -d "username=mkyong&password=abc" http://localhost:8080/api/login/`

Post multipart with files add `-F filesent=@"filepath"` this can be replicated e.g. `$ curl -F extraField="abc" -F files=@"path/to/data.txt" -F files=@"path/to/data2.txt"  http://localhost:8080/api/upload/multi/`

The file can be named `$ curl -F extraField="abc" -F files=@"path/to/data.txt" -F files=@"path/to/data2.txt"  http://localhost:8080/api/upload/multi/`

Post json

windows has trouble with quotes `c:\> curl -H "Content-Type: application/json" -X POST -d {\"username\":\"mkyong\",\"password\":\"abc\"} http://localhost:8080/api/login/`

Linux is ok can can use singles `$ curl -H "Content-Type: application/json" -X POST -d '{"username":"mkyong","password":"abc"}' http://localhost:8080/api/login/`

Also:

`curl -X POST -H "Content-Type: application/json" --data @body.json http://example.com/api

json only output `curl http://example.com/test.json -sb -H "Accept: applicaton/json"`