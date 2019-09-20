# Setting up Elastic Search

The main servces are build in docker-compose from `https://github.com/munnox/docker-elk.git`

Instuctions and info for setting up Elastics search, Log stash, Kibana.

These instuction are mostly for ubuntu 18.04

using:

* auditbeat
* filebeat
* packetbeat
* metricbeat

## Systemlogs (filebeat)

Source <https://www.elastic.co/guide/en/beats/filebeat/current/index.html>

### Install

```
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.3.2-amd64.deb
sudo dpkg -i filebeat-7.3.2-amd64.deb
```

### Configure

Setup in `/etc/filebeat/filebeat.yml`

```
output.elasticsearch:
  hosts: ["https://<server_name>:9200"]

  # Optional protocol and basic auth credentials.
  #protocol: "https"
  username: "elastic"
  password: "PleaseChangeMe"
  ssl.certificate_authorities: ["mainCA.crt"]
  ssl.certificate: "client.crt"
  ssl.key: "client.key"

setup.kibana:
  host: "https://<server_name>:5601"
  ssl.certificate_authorities: ["mainCA.crt"]
  ssl.certificate: "client.crt"
  ssl.key: "client.key"
```

Setup service

```
sudo filebeat modules enable system
sudo filebeat setup
```

### Start the Service

```
sudo service filebeat start
```

or 

```
sudo systemctl enable filebeat.service
sudo systemctl start filebeat.service
```

## Metricbeat

Source <https://www.elastic.co/guide/en/beats/metricbeat/current/index.html>

### Install

```
curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.3.2-amd64.deb
sudo dpkg -i metricbeat-7.3.2-amd64.deb
```

### Configure

Setup in `/etc/metricbeat/metricbeat.yml`

```
output.elasticsearch:
  hosts: ["https://<server_name>:9200"]

  # Optional protocol and basic auth credentials.
  #protocol: "https"
  username: "elastic"
  password: "PleaseChangeMe"
  ssl.certificate_authorities: ["mainCA.crt"]
  ssl.certificate: "client.crt"
  ssl.key: "client.key"

setup.kibana:
  host: "https://<server_name>:5601"
  ssl.certificate_authorities: ["mainCA.crt"]
  ssl.certificate: "client.crt"
  ssl.key: "client.key"
```

Setup service

```
sudo metricbeat modules enable system
sudo metricbeat setup
```

Store the example dashboards in kibana:

```
metricbeat setup --dashboards
```

### Start the Service

```
sudo service metricbeat start

# or 

sudo systemctl enable metricbeat.service
sudo systemctl start metricbeat.service
```

## Auditbeat

Source <https://www.elastic.co/guide/en/beats/auditbeat/current/index.html>

### Install

```
curl -L -O https://artifacts.elastic.co/downloads/beats/auditbeat/auditbeat-7.3.2-amd64.deb
sudo dpkg -i auditbeat-7.3.2-amd64.deb
```

### Configure

Setup in `/etc/auditbeat/auditbeat.yml`

```
output.elasticsearch:
  hosts: ["https://<server_name>:9200"]

  # Optional protocol and basic auth credentials.
  #protocol: "https"
  username: "elastic"
  password: "PleaseChangeMe"
  ssl.certificate_authorities: ["mainCA.crt"]
  ssl.certificate: "client.crt"
  ssl.key: "client.key"

setup.kibana:
  host: "https://<server_name>:5601"
  ssl.certificate_authorities: ["mainCA.crt"]
  ssl.certificate: "client.crt"
  ssl.key: "client.key"
```

Setup service

```
sudo auditbeat modules enable system
sudo auditbeat setup
```

Store the example dashboards in kibana:

```
auditbeat setup --dashboards
```

### Start the Service

```
sudo service auditbeat start

# or 

sudo systemctl enable auditbeat.service
sudo systemctl start auditbeat.service
```

## Packetbeat

Source <https://www.elastic.co/guide/en/beats/packetbeat/current/index.html>

### Install

```
sudo apt-get install libpcap0.8
curl -L -O https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-7.3.2-amd64.deb
sudo dpkg -i packetbeat-7.3.2-amd64.deb
```

### Configure

Setup in `/etc/filebeat/filebeat.yml`

```
output.elasticsearch:
  hosts: ["https://<server_name>:9200"]

  # Optional protocol and basic auth credentials.
  #protocol: "https"
  username: "elastic"
  password: "PleaseChangeMe"
  ssl.certificate_authorities: ["mainCA.crt"]
  ssl.certificate: "client.crt"
  ssl.key: "client.key"

setup.kibana:
  host: "https://<server_name>:5601"
  ssl.certificate_authorities: ["mainCA.crt"]
  ssl.certificate: "client.crt"
  ssl.key: "client.key"
```

Store the example dashboards in kibana:

```
packetbeat setup --dashboards
```

### Start the Service

```
sudo service packetbeat start

# or

sudo systemctl enable packetbeat.service
sudo systemctl start packetbeat.service
```

