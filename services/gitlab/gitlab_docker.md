# Gitlab Docker setup

Source https://docs.gitlab.com/omnibus/docker/#install-gitlab-using-docker-compose

```
sudo docker run --detach \
--hostname gitlab.example.com \
--publish 443:443 --publish 80:80 --publish 22:22 \
--name gitlab \
--restart always \
--volume /srv/gitlab/config:/etc/gitlab \
--volume /srv/gitlab/logs:/var/log/gitlab \
--volume /srv/gitlab/data:/var/opt/gitlab \
gitlab/gitlab-ce:latest
```

## HTTPS

* https://docs.gitlab.com/omnibus/settings/nginx.html#enable-https

## SSL

* https://docs.gitlab.com/omnibus/settings/ssl.html
* https://docs.gitlab.com/ee/user/project/pages/lets_encrypt_for_gitlab_pages.html

Add to `/elc/gitlab/gitlab.rb`

```
letsencrypt['enable'] = true                      # GitLab 10.5 and 10.6 require this option
external_url "https://gitlab.example.com"         # Must use https protocol
letsencrypt['contact_emails'] = ['foo@email.com'] # Optional
```

```
registry_external_url "https://registry.example.com"     # container registry, must use https protocol
mattermost_external_url "https://mattermost.example.com" # mattermost, must use https protocol
#registry_nginx['ssl_certificate'] = "path/to/cert"      # Must be absent or commented out
```

```
# This example renews every 7th day at 12:30
letsencrypt['auto_renew_hour'] = "12"
letsencrypt['auto_renew_minute'] = "30"
letsencrypt['auto_renew_day_of_month'] = "*/7"
```
