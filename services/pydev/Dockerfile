FROM python:3.9

# RUN apt-get update && apt-get install -y --no-install-recommends neovim curl git
RUN apt-get update && apt-get install -y neovim curl git tmux

# COPY ../../ /repo/unix_config/
RUN git clone https://github.com/munnox/unix_config /repo/unix_config

RUN mkdir -p ~/.config/nvim
RUN cd /repo/unix_config && python3 use_setting.py

WORKDIR /home/

CMD nvim
