---
title: Windows
categories:
  - null
tags:
  - null
date: 2024-12-06 15:58:15
mathjax:
---

## 右键以终端方式进入当前文件夹

编辑文件：MS-DOS.REG，内容如下，保存文件并双击导入注册表。

```bash
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\Directory\shell\MS-DOS]
@="MS-DOS"

[HKEY_CLASSES_ROOT\Directory\shell\MS-DOS\command]
@="cmd.exe /s /k pushd \"%V\""
```

