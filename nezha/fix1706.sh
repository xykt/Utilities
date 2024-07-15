#!/bin/bash
echo "提示: 此脚本将升级/降级本机nezha-agent至v0.17.06版本（最后一个Websocket-WebShell版本，适配dashboard≤v0.17.09），并禁用自动升级功能。"
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
cd ~
wget https://github.com/nezhahq/agent/releases/download/v0.17.6/nezha-agent_linux_amd64.zip
unzip nezha-agent_linux_amd64.zip
if command -v systemctl > /dev/null 2>&1; then
    systemctl stop nezha-agent
    cp nezha-agent /opt/nezha/agent
    sudo sed -i '/ExecStart=/ s/$/ --disable-auto-update/' /etc/systemd/system/nezha-agent.service
    systemctl daemon-reload
    systemctl restart nezha-agent
elif command -v rc-service > /dev/null 2>&1; then
    rc-service nezha-agent stop
    cp nezha-agent /opt/nezha/agent
    sudo sed -i 's#command_args="\(.*\)"#command_args="\1 --disable-auto-update"#' /etc/init.d/nezha-agent
    rc-update add nezha-agent
    rc-service nezha-agent start
else
    echo "Unsupported init system"
    exit 1
fi
rm nezha-agent_linux_amd64.zip
rm nezha-agent
