#This Dockerfile uses the ubuntu image
#Author: Rokas_Urbelis
#Email : Rokas.Yang@gmail.com
#Blog  : https://blog.linux-code.com
FROM ubuntu:latest
MAINTAINER RokasUrbelis(Based on github deepin-wine-ubuntu project)

ENV DEBIAN_FRONTEND=noninteractive
COPY link.sh /root/
COPY winedeb/* /root/deepin-wine-ubuntu/

WORKDIR /
RUN groupadd -r ubuntu \
    && useradd -r -g ubuntu -G audio,video ubuntu \
    && mkdir -p /home/ubuntu/Downloads \
    && chown -R ubuntu:ubuntu /home/ubuntu \
    && usermod -u 1000 ubuntu \
    && groupmod -g 1000 ubuntu \
    && apt update \
    && DEBIAN_FRONTEND=noninteractive apt install -y wget locales ttf-wqy-zenhei sudo tzdata keyboard-configuration \
    && locale-gen en_US.UTF-8 zh_CN.UTF-8 zh_CN.GBK \
    && update-locale LANG=zh_CN.UTF-8 \
    && yes|bash /root/deepin-wine-ubuntu/install_*.sh \
    && /bin/bash /root/link.sh \
    && rm -f /root/link.sh \
    && rm -rf /root/deepin-wine-ubuntu \
    #&& git clone --depth 1 https://github.com/wszqkzqk/deepin-wine-ubuntu.git \
    #&& apt remove --purge git -y \
    #&& apt autoremove --purge -y \
    #&& echo "deb [trusted=yes] http://mirrors.aliyun.com/deepin lion main contrib non-free" >> /etc/apt/sources.list \
    #&& echo "deb [trusted=yes] https://deepin-wine.i-m.dev /" >> /etc/apt/sources.list \
    #&& apt update \
    #&& apt install deepin.com.wechat deepin.com.qq.im -fy \
    && echo "root:password" | chpasswd \
    && ln -fs /usr/share/zoneinfo/Asia/Taipei /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && apt autoremove --purge -y \
    && apt autoclean -y \
    && rm -rf /var/lib/apt/lists/*

ENV LC_CTYPE=zh_CN.UTF-8 \
    XMODIFIERS="@im=fcitx"

USER ubuntu
WORKDIR /home/ubuntu
CMD ["/bin/bash"]
