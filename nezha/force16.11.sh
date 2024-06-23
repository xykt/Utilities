#!/bin/bash
cd ~
wget https://github.com/nezhahq/agent/releases/download/v0.16.11/nezha-agent_linux_amd64.zip
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
