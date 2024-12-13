---
title: UNIX常用命令
categories:
  - [Unix]
tags:
  - Unix
date: 2024-11-03 19:02:39
mathjax:
---

## find

> 查找当前目录下，所有以"(1)"结尾的文件，并删除
>
> 因为：文件名中含有**'('**与**')'**特殊字符，find命令需要使用"-print0"参数，对应的xargs使用"-0"参数

```bash
find ./ -name "*(1).*" -print0 | xargs -0 rm -f
```

或：

```bash
find ./ -name "*(1).*" -exec rm -f {} \;
```

> 删除所有以**"._"**开头的文件：

```bash
find ./ -name "._*" -type f -exec rm -f {} \;
```

## ffmpeg

### 转换格式(mp4 -> mov)

```bash
ffmpeg -c:v copy -c:a copy -i input.mp4 output.mov
ffmpeg -i input.mp4 output.mov
```

