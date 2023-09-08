---
title: Sing-box
categories:
  - [科学上网, Sing-box]
tags:
  - 科学上网
  - Sing-box
date: 2023-08-11 17:12:15
mathjax:
---

## 服务器安装

```bash
wget https://github.com/SagerNet/sing-box/releases/download/v1.3.6/sing-box_1.3.6_linux_amd64.deb
sudo dpkg -i sing-box_1.3.6_linux_amd64.deb 
```

### 查看已安装文件

```bash
dkpg -c sing-box_1.3.6_linux_amd64.deb
```

```
drwxr-xr-x root/root     0 2023-08-06 00:43 ./etc/
drwxr-xr-x root/root     0 2023-08-06 00:43 ./etc/sing-box/
-rw-r--r-- root/root    599 2023-03-26 01:36 ./etc/sing-box/config.json
drwxr-xr-x root/root     0 2023-08-06 00:43 ./etc/systemd/
drwxr-xr-x root/root     0 2023-08-06 00:43 ./etc/systemd/system/
-rw-r--r-- root/root    510 2023-08-05 14:01 ./etc/systemd/system/sing-box.service
-rw-r--r-- root/root    521 2023-08-05 14:01 ./etc/systemd/system/sing-box@.service
drwxr-xr-x root/root     0 2023-08-06 00:43 ./usr/
drwxr-xr-x root/root     0 2023-08-06 00:43 ./usr/bin/
-rwxr-xr-x root/root 23814144 2023-08-05 13:37 ./usr/bin/sing-box
drwxr-xr-x root/root     0 2023-08-06 00:43 ./usr/share/
drwxr-xr-x root/root     0 2023-08-06 00:43 ./usr/share/licenses/
drwxr-xr-x root/root     0 2023-08-06 00:43 ./usr/share/licenses/sing-box/
-rw-r--r-- root/root    791 2023-08-05 14:01 ./usr/share/licenses/sing-box/LICENSE
```

<!--more-->

### 随机生成密码

```bash
openssl rand -base64 16
```



### 编辑配置文件

> /etc/sing-box/config.json

#### shadow-tls

```json
{
    "log": {
        "level": "info",
        "timestamp": true
    },
    "inbounds": [
        {
            "type": "shadowtls",
            "tag": "shadowtls-in",
            "listen": "::",
            "listen_port": 443,
            "sniff": true,
            "sniff_override_destination": true,
            "detour": "shadowsocks-in",
            "version": 3,
            "users": [
                {
                    "password": "chika"
                }
            ],
            "handshake": {
                "server": "www.bing.com", // 目标网站最低标准：国外网站，支持 TLSv1.3
                "server_port": 443
            },
            "strict_mode": true
        },
        {
            "type": "shadowsocks",
            "tag": "shadowsocks-in",
            "listen": "127.0.0.1",
            "method": "2022-blake3-aes-128-gcm",
            "password": "3P+xaSaFiXsrQ1KCr2Xvxg==" // 执行 openssl rand -base64 16 生成
        }
    ],
    "outbounds": [
        {
            "type": "direct",
            "tag": "direct"
        }
    ]
}
```

### 启动sing-box服务

```bash
systemctl start sing-box
```

### 查看sing-box服务状态

```bash
systemctl status sing-box
```

```
**●** sing-box.service - sing-box service
Loaded: loaded (/etc/systemd/system/sing-box.service; disabled; vendor preset: enabled)
Active: **active (running)** since Fri 2023-08-11 09:22:31 UTC; 8s ago
​    Docs: https://sing-box.sagernet.org
Main PID: 3552 (sing-box)
Tasks: 7 (limit: 1141)
Memory: 2.1M
​    CPU: 9ms
CGroup: /system.slice/sing-box.service
​       └─3552 /usr/bin/sing-box -D /var/lib/sing-box -C /etc/sing-box run

Aug 11 09:22:31 ip-172-31-41-67 systemd[1]: Started sing-box service.
Aug 11 09:22:31 ip-172-31-41-67 sing-box[3552]: TRACE[0000] initializing inbound/shadowtls[0]
Aug 11 09:22:31 ip-172-31-41-67 sing-box[3552]: INFO[0000] inbound/shadowtls[0]: tcp server started at 127.0.0.1:443
Aug 11 09:22:31 ip-172-31-41-67 sing-box[3552]: TRACE[0000] initializing inbound/shadowsocks[shadowsocks-in]
Aug 11 09:22:31 ip-172-31-41-67 sing-box[3552]: INFO[0000] inbound/shadowsocks[shadowsocks-in]: tcp server started at 127.0.0.1:36965
Aug 11 09:22:31 ip-172-31-41-67 sing-box[3552]: INFO[0000] inbound/shadowsocks[shadowsocks-in]: udp server started at 127.0.0.1:45995
Aug 11 09:22:31 ip-172-31-41-67 sing-box[3552]: INFO[0000] sing-box started (0.00s)
```

## 客户端安装

### macOS客户端

#### 安装软件包

```bash
wget https://github.com/SagerNet/sing-box/releases/download/v1.3.6/sing-box-1.3.6-darwin-amd64.tar.gz
tar xzvf sing-box-1.3.6-darwin-amd64.tar.gz
```

#### 设置系统代理

> 1. https代理
> 2. 注意端口号：10000，可以自定义

### 编辑配置文件

> config.json

#### shadow-tls

```json
{
    "log": {
        "level": "info",
        "timestamp": true
    },
    "route": {
        "rules": [
            {
                "geosite": [
                    "cn",
                    "private"
                ],
                "geoip": [
                    "cn",
                    "private"
                ],
                "outbound": "direct"
            }
        ]
    },
    "inbounds": [
        {
            "type": "mixed",
            "tag": "mixed-in",
            "listen": "::",
            "listen_port": 10000 //系统代理使用的端口号，可以自定义
        }
    ],
    "outbounds": [
        {
            "type": "shadowsocks",
            "tag": "proxy",
            "detour": "shadowtls-out",
            "method": "2022-blake3-aes-128-gcm",
            "password": "3P+xaSaFiXsrQ1KCr2Xvxg==",
            "udp_over_tcp": {
                "enabled": false,
                "version": 2
            },
            "multiplex": {
                "enabled": true,
                "protocol": "h2mux",
                "max_connections": 4,
                "min_streams": 4,
                "padding": true
            }
        },
        {
            "type": "shadowtls",
            "tag": "shadowtls-out",
            "server": "sb1.gocoin.one",
            "server_port": 443,
            "version": 3,
            "password": "chika",
            "tls": {
                "enabled": true,
                "server_name": "www.bing.com",
                "utls": {
                    "enabled": true,
                    "fingerprint": "chrome"
                }
            }
        },
        {
            "type": "direct",
            "tag": "direct"
        }
    ]
}
```

