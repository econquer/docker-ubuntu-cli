#################################################
# DO NOT MODIFY THIS FILE
#################################################
FROM ubuntu:20.04

ENV container docker
ENV DEBIAN_FRONTEND noninteractive

# packages.docker

RUN sed -i 's/archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list

RUN apt-get update
RUN apt-get dist-upgrade -y 
RUN apt-get install -y apt-utils


# 10_locale.docker
RUN apt-get install -y locales
RUN locale-gen ko_KR.UTF-8

ENV LC_ALL ko_KR.UTF-8


# openjdk8
RUN apt-get install -y openjdk-8-jdk

# redis-tools
RUN apt-get install -y jq
RUN apt-get install -y redis-tools redis-server


# cli-tools

RUN apt-get install -y curl vim htop
RUN apt-get install -y jq

# zsh

RUN apt-get install -y git zsh 
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/g' /root/.zshrc


# fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git /root/.fzf
RUN /root/.fzf/install


# run
RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor

RUN apt-get update
RUN apt-get dist-upgrade -y 

# cleanup
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]


