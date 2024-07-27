#!/bin/bash
echo "提示: 此脚本将禁用nezha-agent的WebShell。"
read -p "是否继续? (y/n): " choice
case "$choice" in 
  y|Y ) 
    echo "继续执行脚本..."
    ;;
  n|N ) 
    echo "脚本已退出。"
    exit 0
    ;;
  * ) 
    echo "无效输入，脚本已退出。"
    exit 1
    ;;
esac
if command -v systemctl > /dev/null 2>&1; then
    systemctl stop nezha-agent
    sudo sed -i '/ExecStart=/ s/$/ --disable-command-execute/' /etc/systemd/system/nezha-agent.service
    systemctl daemon-reload
    systemctl restart nezha-agent
elif command -v rc-service > /dev/null 2>&1; then
    rc-service nezha-agent stop
    sudo sed -i 's#command_args="\(.*\)"#command_args="\1 --disable-command-execute"#' /etc/init.d/nezha-agent
    rc-update add nezha-agent
    rc-service nezha-agent start
else
    echo "Unsupported init system"
    exit 1
fi
