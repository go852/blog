---
title: Naive节点
categories:
  - [Naive, Qv2Ray]
tags:
  - Navie
  - Qv2Ray
  - v2ray
date: 2023-08-10 16:28:23
mathjax:
---

## 服务器安装

### 切换至root用户

```bash
sudo -i
```

### 下载安装脚本

```bash
wget https://raw.githubusercontent.com/imajeason/nas_tools/main/NaiveProxy/do.sh
```

**脚本内容：**

```bash
#!/bin/bash

shell_renew(){
    curl -o /root/.naive.sh https://raw.githubusercontent.com/imajeason/nas_tools/main/NaiveProxy/naive.sh
    chmod +x /root/.naive.sh
    ln -s /root/.naive.sh /usr/bin/naive
    echo
    echo " naive 命令安装完毕，请使用naive进行操作。"
}

shell_renew
```

### 执行安装脚本

```python
chmod +x ./do.sh
./do.sh
```

### 执行naive命令进行安装

```bash
naive
```

输入域名与邮箱。

### 一键安装脚本

```bash
bash <(curl -s -L https://raw.githubusercontent.com/imajeason/nas_tools/main/NaiveProxy/do.sh)
naive
```

### 卸载服务端

```bash
naive
```



## 客户端安装（Qv2ray）

### 下载软件、核心与插件

**Qv2ray软件：**

https://github.com/Qv2ray/Qv2ray

https://github.com/Qv2ray/Qv2ray/releases

https://github.com/Qv2ray/Qv2ray/releases/download/v2.7.0/Qv2ray-v2.7.0-macOS-x64.dmg
https://github.com/Qv2ray/Qv2ray/releases/download/v2.7.0/Qv2ray-v2.7.0-Windows-Installer.exe

### **下载v2ray核心**

[Releases · v2fly/v2ray-core (github.com)](https://github.com/v2fly/v2ray-core/releases)

### **下载NaiveProxy核心**

[Releases · klzgrad/naiveproxy (github.com)](https://github.com/klzgrad/naiveproxy/releases/)

### **下载NaiveProxy插件**

[Releases · Qv2ray/QvPlugin-NaiveProxy (github.com)](https://github.com/Qv2ray/QvPlugin-NaiveProxy/releases)

## Windows客户端配置

### 内核设置

```bash
首选项，内核设置：
1、V2Ray核心可执行文件路径：C:/Users/paul/Downloads/Qv2ray/v2ray-windows-64/v2ray.exe
2、V2Ray资源目录：C:/Users/paul/Downloads/Qv2ray/v2ray-windows-64
检查V2Ray核心设置：
V2Ray4.45.2，注意：5.0以上的版本不能使用。
```

### 插件安装

```bash
1、将下载下来的QvPlugin-NaiveProxy.v3.0.0.Windows-x64.dll文件复制到qv2ray安装目录的plugins子目录里面。
```

![image-20221129150042820](image-20221129150042820.png)

```bash
2、选择NaiveProxy Plugin（已加载）：
在“元数据”的路径看到：C:/Program Files/qv2ray/plugins/QvPlugin-NaiveProxy.v3.0.0.Windows-x64.dll

点击：设定，
Kernel Path：
选择下载的naive.exe文件，如：
C:/Users/paul/Desktop/naiveproxy-v107.0.5304.87-3-win-x64/naive.exe

运行：Test
可以看见：NaiveProxy: naive 107.0.5304.87的版本。
```

![image-20221129150812142](image-20221129150812142.png)

![image-20221129150615961](image-20221129150615961.png)

### 新建代理服务器

```bash
标签：abc
主机：abc.def.come
端口：443
用户名：User
密码：1d416156-2bdc-4470-80e5-6afeab1692d9
```

### 测试代理服务器

```bash
选择代理服务器
右击：测试延迟
```

### 导出配置（json格式）

右击：编辑为JSON：

```bash
{
    "outbounds": [
        {
            "_QV2RAY_USE_GLOBAL_FORWARD_PROXY_": false,
            "mux": {
                "concurrency": 1,
                "enabled": null
            },
            "protocol": "naive",
            "sendThrough": "0.0.0.0",
            "settings": {
                "host": "abc.def.com",
                "padding": null,
                "password": "1d416156-2bdc-4470-80e5-6afeab1692d9",
                "port": 443,
                "protocol": null,
                "username": "User"
            },
            "streamSettings": {
            },
            "tag": "Ly2"
        }
    ]
}
```

## Macos客户端安装及配置

### Qv2ray下载

```bash
wget https://github.com/Qv2ray/Qv2ray/releases/download/v2.7.0/Qv2ray-v2.7.0-macOS-x64.dmg
```

### 安装[V2ray-core版本：4.45.2](https://github.com/v2fly/v2ray-core/releases/tag/v4.45.2)

```bash
wget https://github.com/v2fly/v2ray-core/releases/download/v4.45.2/v2ray-macos-64.zip
```

### V2ray设置

```bash
mkdir ~/Desktop/Qv2Ray
cd ~/Desktop/Qv2Ray
unzip v2ray-macos-64.zip
Qv2ray，首选项，内核设置，
V2Ray核心可执行文件路径：/Users/paul/Desktop/Qv2Ray/v2ray-macos-64/v2ray
V2Ray资源目录：/Users/paul/Desktop/Qv2Ray/v2ray-macos-64
```

### Naive插件

``` bash
wget https://github.com/klzgrad/naiveproxy/releases/download/v114.0.5735.91-3/naiveproxy-v114.0.5735.91-3-mac-x64.tar.xz
tar xjvf naiveproxy-v114.0.5735.91-3-mac-x64.tar.xz
cp naiveproxy-v114.0.5735.91-3-mac-x64/* /Users/paul/Library/Preferences/qv2ray/plugins

wget https://github.com/Qv2ray/QvPlugin-NaiveProxy/releases/download/v3.0.0/QvPlugin-NaiveProxy.v3.0.0.macOS-x64.so
cp QvPlugin-NaiveProxy.v3.0.0.macOS-x64.so /Users/paul/Library/Preferences/qv2ray/plugins
```

### 一键脚本

```bash
#!/bin/bash
mkdir ~/Desktop/Qv2Ray
cd ~/Desktop/Qv2Ray

wget https://github.com/v2fly/v2ray-core/releases/download/v4.45.2/v2ray-macos-64.zip
unzip -d v2ray-macos-64 v2ray-macos-64.zip

wget https://github.com/klzgrad/naiveproxy/releases/download/v114.0.5735.91-3/naiveproxy-v114.0.5735.91-3-mac-x64.tar.xz
tar xjvf naiveproxy-v114.0.5735.91-3-mac-x64.tar.xz
cp naiveproxy-v114.0.5735.91-3-mac-x64/* /Users/paul/Library/Preferences/qv2ray/plugins

wget https://github.com/Qv2ray/QvPlugin-NaiveProxy/releases/download/v3.0.0/QvPlugin-NaiveProxy.v3.0.0.macOS-x64.so
cp QvPlugin-NaiveProxy.v3.0.0.macOS-x64.so /Users/paul/Library/Preferences/qv2ray/plugins

```

### 客户端连接方式

```bash
naive+https://User:89458f76-41f4-403a-8841-6255ffffdcd9@n1.abc.com:443?padding=false#n1
```

## 直接使用naive做系统代理

### 下载naive

```bash
wget https://github.com/klzgrad/naiveproxy/releases/download/v114.0.5735.91-3/naiveproxy-v114.0.5735.91-3-mac-x64.tar.xz
```

### 解压naive

```bash
tar xjvf naiveproxy-v114.0.5735.91-3-mac-x64.tar.xz
cd naiveproxy-v114.0.5735.91-3-mac-x64
sudo ln -snf $(pwd)/naive /usr/local/bin/naive
```

### 编辑config.json文件

```json
{
  "listen": "http://127.0.0.1:8889",
  "proxy": "https://User:48069728-9950-47a3-9bc7-8f211ef0699d@n1.abc.com",
  "log": ""
}
```

### 运行naive

```bash
naive
```





