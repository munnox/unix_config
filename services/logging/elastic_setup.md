# Setting up Elastic Search


The main servces are build in docker-compose from `https://github.com/munnox/docker-elk.git`

Instuctions and info for setting up Elastics search, Log stash, Kibana.

These instuction are mostly for ubuntu 18.04

using:

* auditbeat
* filebeat
* packetbeat
* metricbeat

## GROK

Pattens <https://github.com/logstash-plugins/logstash-patterns-core/tree/master/patterns>
Logstash fiter <https://www.elastic.co/guide/en/logstash/current/plugins-filters-grok.html>

example

```
[48580.013699] audit: type=1131 audit(1569156451.288:2012): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=NetworkManager-dispatcher comm="systemd" exe="/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
```

parsed by 

```
\[%{NUMBER:timespan}\] audit: type=%{NUMBER:type:int} audit(%{GREEDYDATA:audit}): pid=%{NUMBER:pid:int} uid=%{NUMBER:uid:int} auid=%{NUMBER:auid} ses=%{NUMBER:ses} msg='%{GREEDYDATA:msg}'
```

## winlogbeat

for event logging on windows

Source <https://www.elastic.co/guide/en/beats/winlogbeat/current/index.html>

### Install

Need to get and setup Sysmon from sysinternals to aid with the logging

Documentation <https://docs.microsoft.com/en-us/sysinternals/downloads/sysmon>

Download [sysmon](https://download.sysinternals.com/files/Sysmon.zip)

need to set this up for netowrking for example with:

```
sysmon -accepteula –i –h md5,sha256 –n
```

Remove it with 

```
sysmon –u
```

Download from <https://www.elastic.co/downloads/beats/winlogbeat>


### Configure

Setup in `C:\winlogbeat\winlogbeat.yml`

```
output.elasticsearch:
  hosts: ["https://<server_name>:9200"]
  username: "elastic"
  password: "PleaseChangeMe"
  ssl.certificate_authorities: ["mainCA.crt"]

setup.kibana:
  host: "https://<server_name>:5601"
  ssl.certificate_authorities: ["mainCA.crt"]
```

Example here [winlogbeat.yml](./winlogbeat_example.yml)

### Start the Service

```
PS C:\Users\Administrator> cd 'C:\Program Files\Winlogbeat'
PS C:\Program Files\Winlogbeat> .\install-service-winlogbeat.ps1
```

if the script cannot be run use:

```
PowerShell.exe -ExecutionPolicy UnRestricted -File .\install-service-winlogbeat.ps1
```


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

Example here [filebeat.yml](./filebeat_example.yml)

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

Example here [metricbeat.yml](./metricbeat_example.yml)

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

Example here [auditbeat.yml](./auditbeat_example.yml)

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

Example here [packetbeat.yml](./packetbeat_example.yml)

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

## administrating services

```
sudo systemctl status auditbeat.service metricbeat.service filebeat.service
```
