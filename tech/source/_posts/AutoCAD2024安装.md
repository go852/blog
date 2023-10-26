---
title: AutoCAD2024安装
categories:
  - null
tags:
  - null
date: 2023-10-26 11:24:36
mathjax:
---

## 下载

[AutoCAD for Mac下载](https://macapp.org.cn/app/autocad.html)

## 安装

运行安装程序Install Autodesk AutoCAD 2024 for Mac.app

## 注册及破解

### 第一次运行

生成目录$HOME/Library/Application\ Support/Autodesk/AutoCAD\ 2024/

### 显示隐藏文件

```bash
defaults write com.apple.finder AppleShowAllFiles -boolean true ; killall Finder
```

### 拷贝破解文件

方法一、在Finder中拷贝文件

将**/Volumes/AutoCAD\ 2024\ [MacApp]/AutoCAD**文件拷贝到：**/Applications/Autodesk/AutoCAD\ 2024/AutoCAD\ 2024.app/Contents/MacOS/AutoCAD**



方法二、设置终端完全访问权限

> 打开“系统偏好设置 — > 隐私与安全性 — > 完全磁盘访问权限 –> 找到“终端” ，可以看到终端后面的开关没有打开，我们打开它，然后会提示输入你的Mac开机密码，输入密码确认即可开启，这个时候可能会提示你退出终端，这个时候要记得点击退出，不然设置无效！

```bash
sudo cp -a /Volumes/AutoCAD\ 2024\ [MacApp]/AutoCAD /Applications/Autodesk/AutoCAD\ 2024/AutoCAD\ 2024.app/Contents/MacOS/AutoCAD
```

### 不显示隐藏文件

```bash
defaults write com.apple.finder AppleShowAllFiles -boolean false ; killall Finder
```



## 一键破解脚本

```bash
#!/bin/sh

defaults write com.apple.finder AppleShowAllFiles -boolean true ; killall Finder
sudo cp -a /Volumes/AutoCAD\ 2024\ [MacApp]/AutoCAD /Applications/Autodesk/AutoCAD\ 2024/AutoCAD\ 2024.app/Contents/MacOS/AutoCAD
defaults write com.apple.finder AppleShowAllFiles -boolean false ; killall Finder

```

