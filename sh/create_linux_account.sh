#!/bin/bash
set -e

USER="front"
HOME_DIR="/usr/local/docker/nginx/app"
PASSWORD="front"

echo "正在创建用户 $USER ..."
useradd -m -d "$HOME_DIR" -s /bin/bash "$USER"
echo "$USER:$PASSWORD" | chpasswd
chmod -R 777 "$HOME_DIR"

echo "用户 $USER 创建完成！"
echo "家目录: $HOME_DIR"
echo "初始密码: $PASSWORD"
echo "权限已改为 777"