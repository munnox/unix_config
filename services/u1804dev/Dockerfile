FROM ubuntu:18.04


# RUN apt-get update && apt-get install -y --no-install-recommends neovim curl git
RUN apt-get update && \
    # apt remove python python-pip && \
    apt-get install -y neovim curl git tmux sudo && \
    apt-get install -y gcc libffi-dev libssl-dev build-essential time && \
    apt-get install -y python3.8 python3-dev libpython3.8-dev python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# COPY ../../ /repo/unix_config/
run pip3 install pipenv

RUN useradd -ms /bin/bash -G sudo  base
RUN echo "base:Docker!" | chpasswd

RUN mkdir /repo/ && chown base:base -R /repo/

USER base
WORKDIR /home/base/

RUN git clone https://github.com/munnox/unix_config /repo/unix_config 
RUN cd /repo/unix_config/ && git pull && git checkout 5e7f38cf7f5596078fd3fcea977a9189bc7e964d


RUN mkdir -p ~/.config/nvim
RUN cd /repo/unix_config && python3 use_setting.py

# RUN [ "/bin/bash", "-c", "nvim --headless -n -i NONE -es -S <(echo -e 'silent! PluginInstall')"]


# WORKDIR /home/

CMD nvim
