# Docker info

basic docker info for reuse

## Dockerfile

```
FROM ubuntu:18.04

RUN apt-get update && apt-get install -y neovim curl git tmux \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD bash
```

