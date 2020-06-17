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
    && apt install -y wget locales ttf-wqy-zenhei sudo tzdata \
    && locale-gen en_US.UTF-8 zh_CN.UTF-8 zh_CN.GBK \
    && update-locale LANG=zh_CN.UTF-8 \
    && wget -q https://mirrors.aliyun.com/deepin/dists/stable/Release.gpg -O- | apt-key add - \
    && apt-key adv --fetch-keys https://mirrors.aliyun.com/deepin/dists/stable/Release.gpg \
    && apt install deepin.com.wechat deepin.com.qq.im -fy \
    && echo "root:password" | chpasswd \
    && ln -fs /usr/share/zoneinfo/Asia/Taipei /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && apt autoremove --purge -y \
    && apt autoclean -y \
    && rm -rf /var/lib/apt/lists/* \

ENV LC_CTYPE=zh_CN.UTF-8 \
    XMODIFIERS="@im=fcitx"

USER ubuntu
WORKDIR /home/ubuntu
CMD ["/bin/bash"]
