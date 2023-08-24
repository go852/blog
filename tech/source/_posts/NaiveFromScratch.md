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
wget https://github.com/klzgrad/forwardproxy/releases/download/v2.7.3-caddy2-naive/caddy-forwardproxy-naive.tar.xz
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

### 一键安装脚本

https://852us.com/naive

```bash
#!/bin/bash
USER="User"
PASSWORD="!Qaz2023"
while getopts ":h:e:u:p:" opt  
do
  case $opt in
  e)  # 处理 -e 选项
    echo "EMAIL: $OPTARG"
    EMAIL=$OPTARG
    ;;
  h)  # 处理 -h 选项
    echo "HOST: $OPTARG"
    HOST=$OPTARG
    ALIAS=$(echo $HOST | awk -F '.' '{print $1}')
    ;;
  u)  # 处理 -u 选项
    echo "USER: $OPTARG"
    USER=$OPTARG
    ;;
  p)  # 处理 -p 选项
    echo "PASSWORD: $OPTARG"
    PASSWORD=$OPTARG
    ;;
  \?)
    echo "无效参数：-$OPTARG" >&2
    ;;
  esac
done

if [[ -z "$HOST" || -z "$USER" || -z "$PASSWORD" ]]; then
  echo "请设置EMAIL, HOST，USER，PASSWORD参数"
  echo "  -e EMAIL"
  echo "  -h HOST"
  echo "  -u USER"
  echo "  -p PASSWORD"
  echo
  exit 1
fi

cd /tmp

BIN_DIR="/usr/local/bin"
NAIVE_CONFIG_FILE="/etc/naive/config.json"
NAIVE_SERVICE_FILE="/lib/systemd/system/naive.service"
CADDY_SERVICE_FILE="/lib/systemd/system/caddy.service"

install_naive_service() {
  echo "安装naive.service ..."
  echo

# config.json
  if [ ! -d /etc/naive ]; then mkdir /etc/naive; fi
  cat > $NAIVE_CONFIG_FILE <<-EOF
{
  "listen": "http://127.0.0.1:54321",
  "padding": false
}
EOF

  cat > $NAIVE_SERVICE_FILE <<-EOF
[Unit]
Description=Naive Service
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
NoNewPrivileges=true
ExecStart=/usr/local/bin/naive /etc/naive/config.json
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
  systemctl enable naive
  systemctl start naive
  systemctl list-units | grep naive
}

install_caddy_service() {
  echo "安装caddy.service ..."
  echo

# caddy.naive
  if [ ! -d /etc/caddy ]; then mkdir /etc/caddy; fi
  if [ -z "$(grep 'order' /etc/caddy/Caddyfile)" ] ; then 
echo "    
{
  order forward_proxy before reverse_proxy
  order forward_proxy before handle_path
}
$(cat /etc/caddy/Caddyfile)" > /etc/caddy/Caddyfile
  fi 

  cat >/etc/caddy/sites/Caddyfile.naive <<-EOF
:443, $HOST {
  tls $EMAIL
  forward_proxy {
    basic_auth $USER $PASSWORD # 用户名、密码
    hide_ip
    hide_via
    probe_resistance
    upstream http://127.0.0.1:54321
  }  
}
EOF
# caddy.service
  cat > $CADDY_SERVICE_FILE <<-EOF
# Refer to: https://github.com/caddyserver/dist/blob/master/init/caddy.service
# CADDY_SERVICE_FILE="/lib/systemd/system/caddy.service"
[Unit]
Description=Caddy
Documentation=https://caddyserver.com/docs/
After=network.target network-online.target
Requires=network-online.target

[Service]
Type=notify
User=root
Group=root
ExecStart=/usr/local/bin/caddy run --environ --config /etc/caddy/Caddyfile
ExecReload=/usr/local/bin/caddy reload --config /etc/caddy/Caddyfile
TimeoutStopSec=5s
LimitNOFILE=1048576
LimitNPROC=512
PrivateTmp=true
ProtectSystem=full

[Install]
WantedBy=multi-user.target
EOF
  systemctl enable caddy
  systemctl start caddy
  systemctl list-units | grep caddy
}

download_naive() {
  NAIVE_SERVICE="$(systemctl list-unit-files | grep naive)"
  if [ ! -z "$NAIVE_SERVICE" ] ; then
    #echo $NAIVE_SERVICE
    systemctl disable naive
    systemctl stop naive
  fi
  sudo apt install xz-utils
  API_URL="https://api.github.com/repos/klzgrad/naiveproxy/releases/latest?v=$RANDOM"
  #echo NAIVE_VERSION="$(curl -s $API_URL | awk -F '"' '/"tag_name"/{print $4}')"
  NAIVE_VERSION="$(curl -s $API_URL | awk -F '"' '/"tag_name"/{print $4}')"
  echo $NAIVE_VERSION
  DOWN_URL="https://github.com/klzgrad/naiveproxy/releases/download"
  DOWN_URL="$DOWN_URL/$NAIVE_VERSION/naiveproxy-$NAIVE_VERSION-linux-x64.tar.xz"
  echo wget -c $DOWN_URL
  wget -c $DOWN_URL
  tar xJvf naiveproxy-$NAIVE_VERSION-linux-x64.tar.xz
  cp naiveproxy-$NAIVE_VERSION-linux-x64/naive /usr/local/bin/
}

download_caddy() {
  CADDY_SERVICE="$(systemctl list-unit-files | grep naive)"
  if [ ! -z "$CADDY_SERVICE" ] ; then
  #  echo $CADDY_SERVICE
    systemctl disable caddy
    systemctl stop caddy
  fi
  API_JSON="api.json"
  GITHUB_USER="klzgrad"
  REPO_NAME="forwardproxy"
  API_URL="https://api.github.com/repos/$GITHUB_USER/$REPO_NAME/releases/latest?v=$RANDOM"
  echo $API_URL 
  curl -s $API_URL > $API_JSON
  #cat $API_JSON
  RELEASE_VERSION="$(awk -F '"' '/"tag_name"/{print $4}' $API_JSON)"
  echo "RELEASE_VERSION=$RELEASE_VERSION"
  DOWN_URL="$(awk -F '"' '/"browser_download_url"/{print $4}' $API_JSON)"
  echo "DOWN_URL=$DOWN_URL"
  FILE_NAME="$(awk -F '"' '/"name"/{print $4}' $API_JSON)"
  echo "FILE_NAME=$FILE_NAME"
  PATH_NAME="$(echo $FILE_NAME | sed 's/.tar.xz//')"
  echo "PATH_NAME=$PATH_NAME"
  echo wget -c $DOWN_URL
  wget -c $DOWN_URL
  tar xJvf $FILE_NAME
  cp $PATH_NAME/caddy /usr/local/bin/
}

show_info() {
  echo
  echo "naive+https://$USER:$PASSWORD@$HOST:443?padding=false#$ALIAS"
  echo
}

remove_tmp_files() {
  rm -rf api.json
  rm -rf naive*
  rm -rf caddy*
  cd -
}

download_naive
install_naive_service
download_caddy
install_caddy_service
show_info
remove_tmp_files
```

> 使用方式：
>
> ./install.sh -e YOUR_EMAIL -h HOSTNAME

## 客户端连接方式

```
naive+https://user:pass@np2.gocoin.one:443?padding=false#np2
```

