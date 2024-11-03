---
title: UNIX常用命令
categories:
  - null
tags:
  - null
date: 2024-11-03 19:02:39
mathjax:
---

## find

> 查找当前目录下，所有一"(1)"结尾的文件，并删除
>
> 因为：文件名中含有**'('**与**')'**特殊字符，find命令需要使用"-print0"参数，对应的xargs使用"-0"参数

```bash
find ./ -name "*\(1\).*" -print0 | xargs -0 rm -f
```

