---
title: NaiveFromScratch
categories:
  - [naive]
tags:
  - [naive]
date: 2023-08-14 16:46:19
mathjax:
---

## 服务器安装

### TLS证书

#### 安装certbot

```bash
apt install certbot
```

#### 获取证书

```bash
# certbot certonly --standalone -d $domain --agree-to --email $email
certbot certonly --standalone -d np2.abc.com --agree-to --email admin@email.com
```

运行结果：

```
Saving debug log to /var/log/letsencrypt/letsencrypt.log
Requesting a certificate for np1.abc.com

Successfully received certificate.
Certificate is saved at: /etc/letsencrypt/live/np1.abc.com/fullchain.pem
Key is saved at:         /etc/letsencrypt/live/np1.abc.com/privkey.pem
This certificate expires on 2023-11-12.
These files will be updated when the certificate renews.
Certbot has set up a scheduled task to automatically renew this certificate in the background.
We were unable to subscribe you the EFF mailing list because your e-mail address appears to be invalid. You can try again later by visiting https://act.eff.org.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
If you like Certbot, please consider supporting our work by:
 * Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
 * Donating to EFF:                    https://eff.org/donate-le
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
```

#### 更新证书

```bash
certbot renew
```

### 安装Naive

```bash
sudo apt install xz-utils
wget https://github.com/klzgrad/naiveproxy/releases/download/v114.0.5735.91-3/naiveproxy-v114.0.5735.91-3-linux-x64.tar.xz
tar xJvf naiveproxy-v114.0.5735.91-3-linux-x64.tar.xz
cd naiveproxy-v114.0.5735.91-3-linux-x64
sudo ln -snf $(pwd)/naive /usr/bin/naive
```

编辑配置

/etc/naive/config.json

```
{
  "listen": "http://127.0.0.1:54321",
  "padding": false
}
```

#### 命令行运行服务端

```bash
/usr/bin/naive /etc/naive/config.json
```

#### service运行服务端

编辑/lib/systemd/system/naive.service文件：

```
[Unit]
Description=Naive Service
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
NoNewPrivileges=true
ExecStart=/usr/bin/naive /etc/naive/config.json
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

```bash
systemctl daemon-reload
systemctl enable naive
systemctl start naive
systemctl status naive
```

### 安装Caddy

```bash
wget https://github.com/klzgrad/forwardproxy/releases/download/v2.6.4-caddy2-naive/caddy-forwardproxy-naive.tar.xz
tar xJvf caddy-forwardproxy-naive.tar.xz
```

#### basicauth指令

```bash
caddy hash-password
#输入123456作为密码
```

生成结果：

>$2a$14$VaF5ztcQ0nKChrP0ImGmPuyyjeLdVnUO/n69r1ua8fCperXBiXmDG

```
www.abc.com {
  root * /var/caddy/vpn
  file_server 
  basicauth /* {
    admin $2a$14$VaF5ztcQ0nKChrP0ImGmPuyyjeLdVnUO/n69r1ua8fCperXBiXmDG
  }
}
```

访问：

https://admin:123456@www.abc.com/

#### 完整的Caddyfile

```
{
  order forward_proxy before reverse_proxy
  order forward_proxy before handle_path
}
:443, np2.abc.com, np3.abc.com, w2.abc.com {
  tls admin@abc.com
  forward_proxy {
    basic_auth admin !Qaz2023 # 用户名、密码
    hide_ip
    hide_via
    probe_resistance
    upstream http://127.0.0.1:54321
  }
  reverse_proxy https://www.fsf.org {
    header_up Host {upstream_hostport}
    header_up X-Forwarded-Host {host}
  }
  handle_path /api {
    reverse_proxy 127.0.0.1:64730
  }
}

import sites/*
```

## 客户端连接方式

```
naive+https://user:pass@np2.gocoin.one:443?padding=false#np2
```

