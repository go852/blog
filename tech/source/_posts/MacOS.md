---
title: MacOS
categories:
  - [操作系统, MacOS]
tags:
  - 操作系统
  - MacOS
date: 2023-09-14 16:17:41
mathjax:
---

## 命令行开发工具

你也可以在终端中输入命令 `xcode-select --install` 来开始安装过程。你会看到一个面板，要求你安装 Xcode 命令行工具。

## xattr(解决app不能运行的问题)

```bash
sudo xattr -cr appname.app
sudo xattr -rd com.apple.quarantine appname.app
```

## 清除DNS缓存

```bash
sudo killall -HUP mDNSResponder
```

## Finder

### 显示隐含文件

```shell
defaults write com.apple.finder AppleShowAllFiles -bool true
killall Finder
```

### 不显示隐含文件

```shell
defaults write com.apple.finder AppleShowAllFiles -bool false
killall Finder
```

## hdiutil管理dmg文件

### 创建dmg文件

### 转换dmg文件

```bash
# 将AutoCAD2023.dmg文件转换为UDRW格式，并写入AutoCAD_2023_RW.dmg
hdiutil convert -format UDRW -o AutoCAD_2023_RW.dmg AutoCAD2023.dmg 

# 将AutoCAD2023_RW.dmg文件转换为UDRO格式，并写入AutoCAD_2023.dmg
hdiutil convert -format UDRW -o AutoCAD2023.dmg AutoCAD_2023_RW.dmg 

```

## ls

### 带颜色查看

```shell
ls --color
```

## pkgbuild

生成pkg文件

--component: app文件

--install-location: 安装路径，默认：/Applications

```bash
pkgbuild --component pdfmaster.app --install-location /Applications pdfmaster.pkg
```

## Apple Script

### 创建Chrome无痕浏览

https://github.com/HaoChuan9421/private-chrome

打开Apple脚本编辑器，创建新的脚本（app格式）

Google Chrome的命令行典型参数：

--incognito：无痕浏览

--start-fullscreen：全屏模式

--start-maximized：窗口最大化

```bash
if application "Google Chrome" is running then
	tell application "Google Chrome"
		make new window with properties {mode:"incognito"}
	end tell
else
	do shell script "open -a 'Google Chrome' --args --incognito --start-fullscreen --start-maximized"
end if
```

另存为：Chrome.app应用程序。

### iconutil创建图标

从https://github.com/alrra/browser-logos/tree/main/src/chrome下载png文件

```bash
brew install renmae

cd ~/Desktop/Chrome.app
cd Contents
cd Resources

mkdir chrome.iconset
cd chrome.iconset
wget https://raw.githubusercontent.com/alrra/browser-logos/main/src/chrome/chrome_16x16.png
wget https://raw.githubusercontent.com/alrra/browser-logos/main/src/chrome/chrome_24x24.png
wget https://raw.githubusercontent.com/alrra/browser-logos/main/src/chrome/chrome_32x32.png
wget https://raw.githubusercontent.com/alrra/browser-logos/main/src/chrome/chrome_64x64.png
wget https://raw.githubusercontent.com/alrra/browser-logos/main/src/chrome/chrome_128x128.png
wget https://raw.githubusercontent.com/alrra/browser-logos/main/src/chrome/chrome_256x256.png
wget https://raw.githubusercontent.com/alrra/browser-logos/main/src/chrome/chrome_512x512.png

rename 's/chrome/icon/' *.png

cd ..
iconutil -c icns chrome.iconset -o applet.icns

```

将生成的applet.icns文件复制（或移动）到./Chrome.app/Contents/Resources/目录下面，覆盖以前的applet.icsn文件即可。

