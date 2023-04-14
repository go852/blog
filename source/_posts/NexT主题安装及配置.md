---
title: NexT主题安装及配置
categories:
  - null
tags:
  - null
date: 2023-04-14 10:33:46
mathjax:
---

## 安装

方法一、

```bash
npm install hexo-theme-next
```

方法二、

```bash
git clone https://github.com/next-theme/hexo-theme-next themes/next
```

## 复制配置文件

复制主题配置文件到站点根目录，命名为：`_config.主题名称.yml`

安装方法一、

```bash
cp node_modules/_config.yml _config.next.yml
```

安装方法二、

```bash
cp themes/next/_config.yml _config.next.yml
```

## 配置站点

### 设置缓存

```yaml
# Allow to cache content generation.
cache:
  enable: true
```

### 移除非必要文件

```yaml
# Remove unnecessary files after hexo generate.
minify: true
```

### 选择scheme

```yaml
# ---------------------------------------------------------------
# Scheme Settings
# ---------------------------------------------------------------

# Schemes
#scheme: Muse
#scheme: Mist
#scheme: Pisces
scheme: Gemini
```

![Muse主题格式](https://852us.com/2023/04/04/NexT%E4%B8%BB%E9%A2%98%E5%AE%89%E8%A3%85%E5%8F%8A%E9%85%8D%E7%BD%AE/image-20230404080424072.jpg)
