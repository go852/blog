---
title: Python语法
categories:
  - null
tags:
  - null
date: 2024-12-06 16:01:51
mathjax:
---

## 列表

## 字符串

### f""

```python
h = "hello"
w = "world"
f"{h} {w}"
输出：hello world
```



### format函数

```python
# 不带位置转换
"{} {}".format("hello", "world")
输出：hello world

# 带位置转换
"{0} {1}".format("hello", "world")
输出：hello world

"{1} {0} {1}".format("hello", "world")
输出：world hello world
```

