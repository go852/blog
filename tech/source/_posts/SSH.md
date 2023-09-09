---
title: SSH
categories:
  - [程序设计,SSH]
tags:
  - 程序设计
  - SSH
date: 2023-09-09 07:13:03
mathjax:
---

## 客户端

### 配置文件

/etc/ssh/ssh_config

```
TCPKeepAlive=yes
ServerAliveInterval 30
ServerAliveCountMax 10
```

>ServerAliveInterval：30，定期向服务器发送心跳的间隔时间，单位：秒。
>
>ServerAliveCountMax：每个周期向服务器发送心跳的最大重试次数10
>
>每隔30秒，向服务器发出一次心跳。若超过10次请求，都没有发送成功，则会主动断开与服务器端的连接。

<!--more-->

### 命令行

```
ssh -o TCPKeepAlive=yes -o ServerAliveInterval=30 -o ServerAliveCountMax=10 user@server
```

## 服务器端

### 配置文件

/etc/ssh/sshd_config

```bash
ClientAliveInterval 30
ClientAliveCountMax 10
```

>ClientAliveInterval：30，定期向客户端发送心跳的间隔时间，单位：秒。
>
>ServerAliveCountMax：每个周期向客户端发送心跳的最大重试次数10
>
>每隔30秒，向客户端发出一次心跳。若超过10次请求，都没有发送成功，则会主动断开与客户端的连接。
