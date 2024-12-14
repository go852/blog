---
title: Brew
categories:
  - [操作系统,macOS]
tags:
  - 操作系统
  - macOS
  - Brew
date: 2024-12-09 17:57:37
mathjax:
---

# Brew安装

## 修改SHELL

```bash
chsh -u paul -s /bin/bash
```

退出后重新进入SHELL

```bash
sudo vim /etc/bashrc
在文件末尾，增加以下行：
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
```

加载/etc/bashrc文件：

```bash
. /etc/bashrc
```

安装brew

```bash
/bin/bash -c "$(curl -fsSL https://cdn.jsdelivr.net/gh/Homebrew/install@HEAD/install.sh)"
```

