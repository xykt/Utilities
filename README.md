# Utilities
Useful Tools

## nezha相关（Debian/Ubuntu/Centos/Alpine）

#### 缓解LXC超开等资源紧张机器nezha-agent频繁掉线的问题
```
bash <(curl -s https://raw.githubusercontent.com/xykt/Utilities/main/nezha/lxc_error_reducer.sh)
```
#### nezha-agent优先展示IPv6旗帜（需不低于v0.17.5）
```
bash <(curl -s https://raw.githubusercontent.com/xykt/Utilities/main/nezha/ipv6flag.sh)
```
#### 禁用nezha-agent自动更新
```
bash <(curl -s https://raw.githubusercontent.com/xykt/Utilities/main/nezha/noupgrade.sh)
```
#### 禁用nezha-agent自动更新，并强制版本固定为v0.17.06（最后一个Websocket-WebShell版本，适配dashboard ≤ v0.17.09）
```
bash <(curl -s https://raw.githubusercontent.com/xykt/Utilities/main/nezha/fix1706.sh)
```
#### 禁用nezha-agent的Webshell
```
bash <(curl -s https://raw.githubusercontent.com/xykt/Utilities/main/nezha/nowebshell.sh)
```
