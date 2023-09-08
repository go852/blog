---
title: yt-dlp
categories:
  - [音视频, Yt-dlp]
tags:
  - 音视频
  - Yt-dlp
date: 2023-07-27 14:39:26
mathjax:
---

# Youtue下载工具yt-dlp

## 安装

### github库

> [yt-dlp](https://github.com/yt-dlp/yt-dlp)

### macos平台安装

> [yt-dlp_macos 2023.07.06](https://github.com/yt-dlp/yt-dlp/releases/download/2023.07.06/yt-dlp_macos)

也可以使用brew进行安装：

```bash
brew install yt-dlp
brew install ffmpeg
```

### Linux平台安装

> [yt-dlp_linux 2023.07.06](https://github.com/yt-dlp/yt-dlp/releases/download/2023.07.06/yt-dlp_linux)

### Windows平台安装

> [yt-dlp.exe 2023.07.06](https://github.com/yt-dlp/yt-dlp/releases/download/2023.07.06/yt-dlp.exe)

### 跨平台脚本

> [yt-dlp 2023.07.06](https://github.com/yt-dlp/yt-dlp/releases/download/2023.07.06/yt-dlp)

类Unix平台包括Linux与macOS，建立/usr/bin/yt-dlp到上述下载文件的符号链接，或者将将文件复制到/usr/bin目录。

```bash
sudo cp yt-dlp /usr/bin/
```

<!--more-->

## 下载音视频

### 基础下载方式

命令：yt-dlp 视频流URL

```bash
yt-dlp https://www.youtube.com/watch?v=SK6SCATFVlg
```

### 最佳音视频下载

```bash
yt-dlp -f 'bv[ext=mp4]+ba[ext=m4a]' --embed-thumbnail --merge-output-format mp4 https://www.youtube.com/watch?v=1u90Tke_5Bs

yt-dlp -f 'bv[ext=mp4]+ba[ext=m4a]' --embed-thumbnail --embed-subs --merge-output-format mp4 https://www.youtube.com/watch?v=10f5T2Blpf4
```

### 选项

```
--list-subs 列出所有的字幕
--write-subs 下载字幕
--embed-subs 嵌入字幕
--sub-langs 指定语言的字幕，如：英语："en",中文："zh"或者所有"all"
--write-auto-subs 下载自动生成的字幕

--write-thumbnail 下载封面
-embed-thumbnail 嵌入封面
```

### 别名

```bash
alias y='yt-dlp -f ba+bv --sub-langs all --embed-subs --embed-thumbnail --merge-output-format mp4'
alias ye='yt-dlp -f ba+bv --sub-langs en --embed-subs --embed-thumbnail --merge-output-format mp4'
alias yc='yt-dlp -f ba+bv --sub-langs zh --embed-subs --embed-thumbnail --merge-output-format mp4'
alias yec='yt-dlp -f ba+bv --sub-langs "en,zh" --embed-subs --embed-thumbnail --merge-output-format mp4'

alias yae='yt-dlp -f ba+bv --write-auto-subs --sub-langs en --embed-subs --embed-thumbnail --merge-output-format mp4'
alias yac='yt-dlp -f ba+bv --write-auto-subs --sub-langs zh --embed-subs --embed-thumbnail --merge-output-format mp4'
alias yaec='yt-dlp -f ba+bv --write-auto-subs --sub-langs "en,zh" --embed-subs --embed-thumbnail --merge-output-format mp4'
```

