## 1.1运行容器

#### 需要提前创建所需要的文件夹，不然会导致解压时权限不正确，无法运行
#### $HOME/wine 你当前用户目录下新建wine目录
````
docker run --rm -ti \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v $HOME/Downloads:/home/ubuntu/Downloads \
  -v $HOME/wine:/home/ubuntu \
  -e DISPLAY=unix$DISPLAY \
  -e GDK_SCALE \
  -e GDK_DPI_SCALE \
  --name wine \
  rdvde/wine
````
## 1.2 输入需要运行的程序名

## 2.1 后台运行容器
````
docker run -d -ti \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v $HOME/Downloads:/home/ubuntu/Downloads \
  -v $HOME/wine:/home/ubuntu \
  -e DISPLAY=unix$DISPLAY \
  -e GDK_SCALE \
  -e GDK_DPI_SCALE \
  --name wine \
  rdvde/wine
````
#### 2.2 启动命令窗口

$ docker exec -ti wine /bin/bash

#### 2.3 以后再次运行

$ docker restart wine && docker exec -ti wine /bin/bash

## 1.2＆2.3 执行需要运行的应用
QQ
TIM
WeChat
BaiduNetDisk
ThunderSpeed
Foxmail

## 提示No protocol specified错误，请在主机运行：
````
xhost +
````
# 原作者
[github](https://github.com/RokasUrbelis/docker-wine-linux)
