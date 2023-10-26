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

## 第一次运行

生成目录$HOME/Library/Application\ Support/Autodesk/AutoCAD\ 2024/



## 显示隐藏文件

```bash
defaults write com.apple.finder AppleShowAllFiles -boolean true ; killall Finder
```



## 在Finder中拷贝文件

将**/Volumes/AutoCAD\ 2024\ [MacApp]/AutoCAD**文件拷贝到：**/Applications/Autodesk/AutoCAD\ 2024/AutoCAD\ 2024.app/Contents/MacOS/AutoCAD**

```bash
sudo cp -a /Volumes/AutoCAD\ 2024\ [MacApp]/AutoCAD /Applications/Autodesk/AutoCAD\ 2024/AutoCAD\ 2024.app/Contents/MacOS/AutoCAD
```



## 不显示隐藏文件

```bash
defaults write com.apple.finder AppleShowAllFiles -boolean false ; killall Finder
```

