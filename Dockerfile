#This Dockerfile uses the ubuntu image
#Author: Rokas_Urbelis
#Email : Rokas.Yang@gmail.com
#Blog  : https://blog.linux-code.com
FROM rdvde/ubuntu-desktop-lxde-vnc
MAINTAINER RokasUrbelis(Based on github deepin-wine-ubuntu project)
ENV HOME=/home/user \
    SHELL=/bin/bash
WORKDIR /
RUN apt update \
    && apt install -y git \
    && apt autoclean -y \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && git clone https://github.com/wszqkzqk/deepin-wine-ubuntu.git \
    && mv deepin-wine-ubuntu /root/
COPY link.sh /root/
COPY deb/ /root/deepin-wine-ubuntu/
#COPY sources.list /etc/apt/
RUN apt-get update

RUN apt-get install wget git locales ttf-wqy-zenhei sudo -y
RUN apt-get clean && apt-get autoclean
ENV LC_CTYPE=zh_CN.UTF-8 \
    XMODIFIERS="@im=fcitx"

RUN \
  locale-gen en_US.UTF-8 zh_CN.UTF-8 \
  zh_CN.GBK && \
  update-locale LANG=zh_CN.UTF-8

# Define default command.

RUN cd /root/deepin-wine-ubuntu \
    #&& mkdir -p $HOME/.config/autostart-scripts/ \
    && yes|bash ./install.sh
#RUN cd && ln -s /opt/deepin-wine-ubuntu/app/* .
RUN /bin/bash /root/link.sh && rm -f /root/link.sh
RUN rm -rf /root/deepin-wine-ubuntu

EXPOSE 80
WORKDIR /root
HEALTHCHECK --interval=30s --timeout=5s CMD curl --fail http://127.0.0.1:6079/api/health
ENTRYPOINT ["/startup.sh"]
