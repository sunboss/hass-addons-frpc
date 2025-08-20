# Home Assistant FRPC 加载项

[![GitHub Release](https://img.shields.io/github/release/sunboss/hass-addons-frpc.svg)](https://github.com/sunboss/hass-addons-frpc/releases)
[![GitHub License](https://img.shields.io/github/license/sunboss/hass-addons-frpc.svg)](LICENSE)

## 概述
本加载项将 FRPC（FRP 客户端）集成到 Home Assistant，支持通过反向代理隧道暴露本地服务。它支持多端口连接和多架构运行（aarch64、amd64、armhf、armv7、i386），适用于不同硬件平台。

- **版本格式**：YYYYMMDD.序列号（例如，20250820.01）
- **维护者**：sunboss (sunboss@qq.com)
- **FRP 版本**：0.60.0（请根据需要更新 Dockerfile）
- **支持架构**：aarch64, amd64, armhf, armv7, i386

## 安装
1. 在 Home Assistant 中，进入 **Supervisor > 加载项商店 > 仓库**。
2. 添加自定义仓库 URL：`https://github.com/sunboss/hass-addons-frpc`。
3. 刷新加载项列表，找到并安装“FRPC 加载项”。
4. 配置选项并启动加载项。

## 配置选项
通过加载项的“配置”选项卡进行设置。除标明“可选”外，所有字段均为必填。

| 选项 | 类型 | 描述 | 示例 |
|------|------|------|------|
| `server_addr` | 字符串 | FRP 服务器地址（你的 FRPS 主机）。 | `frps.example.com` |
| `server_port` | 整数 | FRP 服务器端口，默认 7000。 | `7000` |
| `token` | 字符串（可选） | FRPS 的认证令牌。 | `your-secret-token` |
| `user` | 字符串（可选） | 代理的用户前缀。 | `myuser` |
| `ports` | 对象列表 | 端口映射数组，支持多个并发连接。每个对象包含：<br>- `name`：唯一名称（例如，“web”）。<br>- `type`：协议（tcp, udp, http, https, stcp, xtcp, sudp）。<br>- `local_ip`：本地 IP 地址。<br>- `local_port`：本地端口。<br>- `remote_port`：FRPS 上的远程端口。 | ```<br>[<br>  {<br>    "name": "web",<br>    "type": "tcp",<br>    "local_ip": "127.0.0.1",<br>    "local_port": 8080,<br>    "remote_port": 8080<br>  },<br>  {<br>    "name": "ssh",<br>    "type": "tcp",<br>    "local_ip": "127.0.0.1",<br>    "local_port": 22,<br>    "remote_port": 2222<br>  }<br>]<br>``` |

### 示例完整配置（Home Assistant 中的 YAML）
```yaml
server_addr: frps.example.com
server_port: 7000
token: secret
user: sunboss
ports:
  - name: http_server
    type: http
    local_ip: 192.168.1.100
    local_port: 80
    remote_port: 80
  - name: mqtt
    type: tcp
    local_ip: 127.0.0.1
    local_port: 1883
    remote_port: 1883
