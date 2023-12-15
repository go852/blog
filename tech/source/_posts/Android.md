---
title: Android
categories:
  - Android
tags:
  - Android
date: 2023-12-13 20:12:13
mathjax:
---

## 安装android-platform-tools

```bash
brew install android-platform-tools --cask
```

## 手机端

安装"[Terminal Emulator for Android](https://jackpal.github.io/Android-Terminal-Emulator/)"

## Adb命令

## 启动服务器

```shell
adb start-server
```

## 停止服务器

```shell
adb kill-server
```

### 连接设备

```shell
adb devices
adb devices -l
```

## 获取屏幕尺寸

```shell
adb shell wm size
```

> Physical size: 1344x2772
>
> Override size: 1152x2376

### 模拟屏幕滑动

```shell
adb shell input swipe 500 2000 500 1000
```

> 坐标：左上角为原点（0,0）
>
> 从（500，2000）上滑到（500,1000）

## 随机间隔

```shell
sleep $(((RANDROM % 70 / 10 + 3)))
或：
t=$(echo "scale=2;$RANDOM % 7000 / 10 + 3" | bc)
echo $t
sleep $t
```

## 代码

```shell
#!/bin/sh

while getopts ":s:" opt
do
  case $opt in
  s)
    ID=$OPTARG
    ;;
  esac
done

if [ $ID ]; then
  OPT_ID="-s $ID"
fi
ADB="adb $OPT_ID"

XMAX=$($ADB shell wm size | awk -F ': ' '{print $2}' | sed 's/x.*//')
YMAX=$($ADB shell wm size | awk -F ': ' '{print $2}' | sed 's/.*x//')
echo "XMAX: $XMAX, YMAX:$YMAX"

swipe(){
  echo $ADB shell input swipe $1 $2 $3 $4
  $ADB shell input swipe $1 $2 $3 $4
}

while true; do
  t=$(echo "scale=2;$RANDOM % 3999 / 10 + 3.27" | bc)
  x1=$((XMAX * (RANDOM % 10 + 45) / 100))
  y1=$((YMAX * (RANDOM % 10 + 80) / 100))
  x2=$((x1 + XMAX * (RANDOM % 10) / 100))
  y2=$((y1 - YMAX * (RANDOM % 30 + 30) / 100))
  echo "${t}s: $x1 $y1 $x2 $y2"
  swipe $x1 $y1 $x2 $y2
  sleep $t
done
```

