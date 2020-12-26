FROM ubuntu:18.04

# RUN apt-get update && apt-get install -y --no-install-recommends neovim curl git
RUN apt-get update && apt-get install -y neovim curl git tmux python3.8 python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# COPY ../../ /repo/unix_config/
run pip3 install pipenv

run git clone https://github.com/munnox/unix_config /repo/unix_config

RUN useradd -ms /bin/bash  base
USER base
WORKDIR /home/base/

RUN mkdir -p ~/.config/nvim
RUN cd /repo/unix_config && python3 use_setting.py

# RUN [ "/bin/bash", "-c", "nvim --headless -n -i NONE -es -S <(echo -e 'silent! PluginInstall')"]


# WORKDIR /home/

CMD nvim
