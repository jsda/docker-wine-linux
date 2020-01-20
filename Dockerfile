#This Dockerfile uses the ubuntu image
#Author: Rokas_Urbelis
#Email : Rokas.Yang@gmail.com
#Blog  : https://blog.linux-code.com
FROM ubuntu:latest
MAINTAINER RokasUrbelis(Based on github deepin-wine-ubuntu project)

WORKDIR /
RUN groupadd -r ubuntu \
    && useradd -r -g ubuntu -G audio,video ubuntu \
    && mkdir -p /home/ubuntu/Downloads \
    && chown -R ubuntu:ubuntu /home/ubuntu \
    && usermod -u 1000 ubuntu \
    && groupmod -g 1000 ubuntu \
    && apt update \
    && apt install -y git wget git locales ttf-wqy-zenhei sudo \
    && apt autoclean -y \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && git clone https://github.com/RokasUrbelis/deepin-wine-ubuntu.git \
    && mv deepin-wine-ubuntu /root/
COPY link.sh /root/
COPY deb/ /root/deepin-wine-ubuntu/

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

USER ubuntu
CMD ["/bin/bash"]
