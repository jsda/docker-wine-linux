#This Dockerfile uses the ubuntu image
#Author: Rokas_Urbelis
#Email : Rokas.Yang@gmail.com
#Blog  : https://blog.linux-code.com
FROM ubuntu:latest
MAINTAINER RokasUrbelis(Based on github deepin-wine-ubuntu project)

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /
RUN groupadd -r ubuntu \
    && useradd -r -g ubuntu -G audio,video ubuntu \
    && mkdir -p /home/ubuntu/Downloads \
    && chown -R ubuntu:ubuntu /home/ubuntu \
    && usermod -u 1000 ubuntu \
    && groupmod -g 1000 ubuntu \
    && apt update \
    && apt install -y git wget locales ttf-wqy-zenhei sudo tzdata \
    && locale-gen en_US.UTF-8 zh_CN.UTF-8 zh_CN.GBK \
    && update-locale LANG=zh_CN.UTF-8 \
    && apt install -t bionic deepin.com.wechat deepin.com.qq.im -fy \
    && echo "root:password" | chpasswd \
    && ln -fs /usr/share/zoneinfo/Asia/Taipei /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && git clone --depth 1 https://github.com/wszqkzqk/deepin-wine-ubuntu.git \
    && apt remove --purge git -y \
    && apt autoremove --purge -y \
    && apt autoclean -y \
    && rm -rf /var/lib/apt/lists/* \
    && mv deepin-wine-ubuntu /root/
COPY link.sh /root/
COPY deb/ /root/deepin-wine-ubuntu/

ENV LC_CTYPE=zh_CN.UTF-8 \
    XMODIFIERS="@im=fcitx"


# Define default command.

RUN cd /root/deepin-wine-ubuntu \
    #&& mkdir -p $HOME/.config/autostart-scripts/ \
    && yes|bash ./install_*.sh
#RUN cd && ln -s /opt/deepin-wine-ubuntu/app/* .
RUN /bin/bash /root/link.sh && rm -f /root/link.sh
RUN rm -rf /root/deepin-wine-ubuntu

USER ubuntu
CMD ["/bin/bash"]
