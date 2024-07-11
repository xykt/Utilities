#!/bin/bash
if command -v systemctl > /dev/null 2>&1; then
    systemctl stop nezha-agent
    sudo sed -i '/ExecStart=/ s/$/ --use-ipv6-countrycode/' /etc/systemd/system/nezha-agent.service
    systemctl daemon-reload
    systemctl restart nezha-agent
elif command -v rc-service > /dev/null 2>&1; then
    rc-service nezha-agent stop
    sudo sed -i 's#command_args="\(.*\)"#command_args="\1 --use-ipv6-countrycode"#' /etc/init.d/nezha-agent
    rc-update add nezha-agent
    rc-service nezha-agent start
else
    echo "Unsupported init system"
    exit 1
fi
