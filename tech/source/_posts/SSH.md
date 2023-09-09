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

## 变量

/etc/ssh/ssh_config

```
ServerAliveInterval 30
ServerAliveCountMax 10
```

>ServerAliveInterval：30，定期向服务器发送心跳的间隔时间，单位：秒。
>
>ServerAliveCountMax：每个周期向服务器发送心跳的最大重试次数10
>
>每隔30秒，向服务器发出一次心跳。若超过10次请求，都没有发送成功，则会主动断开与服务器端的连接。
