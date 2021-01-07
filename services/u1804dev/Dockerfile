FROM ubuntu:18.04

# App image without FUSE https://docs.appimage.org/user-guide/troubleshooting/fuse.html#setting-up-fuse-on-ubuntu-debian-and-their-derivatives
ENV APPIMAGE_EXTRACT_AND_RUN=1
ENV NO_CLEANUP=1

# Node version for dev enviroment
ENV NODE_JS_INSTALLED=0
ENV NODE_JS_VERSION=v14.15.3
ENV NODE_JS_DISTRO=linux-x64
ENV NODE_JS_NAME="node-$NODE_JS_VERSION-$NODE_JS_DISTRO"

# RUN apt-get update && apt-get install -y --no-install-recommends neovim curl git
RUN apt-get update && \
    # apt remove python python-pip && \
    apt-get install -y neovim curl git tmux sudo htop && \
    apt-get install -y gcc libffi-dev libssl-dev build-essential time && \
    apt-get install -y python3.8 python3-dev libpython3.8-dev python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf

# COPY ../../ /repo/unix_config/
run pip3 install pipenv

RUN useradd -ms /bin/bash -G sudo  base
RUN echo "base:Docker!" | chpasswd

RUN curl -o /usr/local/bin/nvim -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage && \
    chmod ugo+x /usr/local/bin/nvim && \
    ln -s /usr/local/bin/nvim /usr/local/bin/vim 

RUN curl https://nodejs.org/dist/v14.15.3/$NODE_JS_NAME.tar.xz --output $NODE_JS_NAME.tar.xz && \
    mkdir -p /usr/local/lib/nodejs && \
    tar -xJvf $NODE_JS_NAME.tar.xz -C /usr/local/lib/nodejs


RUN mkdir /repo/ && chown base:base -R /repo/

USER base
WORKDIR /home/base/

RUN git clone https://github.com/munnox/unix_config /repo/unix_config 
RUN cd /repo/unix_config/ && git pull && git checkout 22679e3603a72fae3bba24eebc8c8a0f512df986


RUN mkdir -p ~/.config/nvim
RUN cd /repo/unix_config && python3 use_setting.py

# RUN [ "/bin/bash", "-c", "nvim --headless -n -i NONE -es -S <(echo -e 'silent! PlugInstall')"]
RUN [ "/bin/bash", "-c", "nvim --headless +PlugInstall +qall"]


# WORKDIR /home/

CMD nvim
