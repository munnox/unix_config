FROM rockylinux/rockylinux:8.4

# App image without FUSE https://docs.appimage.org/user-guide/troubleshooting/fuse.html#setting-up-fuse-on-ubuntu-debian-and-their-derivatives
ENV APPIMAGE_EXTRACT_AND_RUN=1
ENV NO_CLEANUP=1

# Node version for dev enviroment
ENV NODE_JS_INSTALLED=0
ENV NODE_JS_VERSION=v14.15.3
ENV NODE_JS_DISTRO=linux-x64
ENV NODE_JS_NAME="node-$NODE_JS_VERSION-$NODE_JS_DISTRO"

# RUN apt-get update && apt-get install -y --no-install-recommends neovim curl git
# RUN yum update -y
RUN dnf update -y
RUN dnf upgrade -y
RUN dnf install epel-release -y
RUN dnf install curl git tmux htop sudo -y
RUN yum install python38 python38-pip python38-devel -y
#     # apt remove python python-pip && \
#     yum install -y neovim curl git tmux sudo htop locales && \
#     yum install -y gcc libffi-dev libssl-dev build-essential time && \
#     yum install -y python3.8 python3-dev libpython3.8-dev python3-pip python3-venv && \
#     yum clean && \
#     rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# RUN sed -i -E 's/^# en_GB(.*)/en_GB\1/' /etc/locale.gen
# RUN echo "en_GB.UTF8 UTF-8" > /etc/locale.gen
# RUN locale-gen
# ENV LC_ALL=en_GB.UTF-8
# ENV LANG=en_GB.UTF-8
# ENV TZ=Europe/London

# RUN localectl set-locale LANG=en_GB.utf8

# Add a personal DNS resolver for look up
# RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf

RUN pip3 install pipenv

RUN useradd -ms /bin/bash -G wheel  base
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

COPY ./ /repo/unix_config/
# RUN git clone https://github.com/munnox/unix_config /repo/unix_config
# RUN cd /repo/unix_config/ && git pull && git checkout 2a1942a571fb8c4292582a9b3b2d4d78d6201568


# RUN mkdir -p ~/.config/nvim
# RUN cd /repo/unix_config && python3 use_setting.py
# RUN cd /repo/unix_config/deploy && ./bootstrap_python.sh
# RUN cd /repo/unix_config/deploy && pipenv install
# RUN cd /repo/unix_config/deploy && pipenv run ansible-playbook deploy.yml

# # RUN [ "/bin/bash", "-c", "nvim --headless -n -i NONE -es -S <(echo -e 'silent! PlugInstall')"]
# RUN [ "/bin/bash", "-c", "nvim --headless +PlugInstall +qall"]

# CMD bash
