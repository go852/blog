---
title: Python语法
categories:
  - [程序设计,Python]
tags:
  - 程序设计
  - Python
date: 2024-12-06 16:01:51
mathjax:
---

## 列表

```python
def get_factors2(number):
  import math
  factors = []
  sqrt = math.sqrt(number)
  # print(f"{number}的开方数{sqrt:.3f}")
  for i in range(1, int(sqrt)+1):
    if number % i == 0:
      factors.append(i)
      if number // i != i:
        factors.append(number // i)
  # print(factors)
  return sorted(factors)

if __name__ == '__main__':
  i = 0
  factors = get_factors2(100)
  print(factors)
  for f in factors:
    print(f"factors[{i}]: {factors[i]}")
    i += 1
```



## 字典

```python
#!/bin/env python3
import os
book_list = [
    {'name':"数学1年级上册", 'url':"https://v3.ykt.cbern.com.cn/65/document/40a22857f0234ab1b1827998d588d927/pdf.pdf"},
    {'name':"数学1年级下册", 'url':"https://v3.ykt.cbern.com.cn/65/document/39c42025a2d848bf8c57ff612439ceb3/pdf.pdf"},
    {'name':"数学2年级上册", 'url':"https://v2.ykt.cbern.com.cn/65/document/6490bb97b5ad41fb83e2b3dbd28b8fe0/pdf.pdf"},
    {'name':"数学2年级下册", 'url':"https://v2.ykt.cbern.com.cn/65/document/2a3ceb3318714414ad0d658af901ea77/pdf.pdf"},
    {'name':"数学3年级上册", 'url':"https://v2.ykt.cbern.com.cn/65/document/32c6b18bca334b439ba061ac958d9d3f/pdf.pdf"},
    {'name':"数学3年级下册", 'url':"https://v3.ykt.cbern.com.cn/65/document/01c4d03170af48d1b88ea5efdfcb5011/pdf.pdf"},
    {'name':"数学4年级上册", 'url':"https://v1.ykt.cbern.com.cn/65/document/f86d42fd514c4945b27a4166e3deb8a3/pdf.pdf"},
    {'name':"数学4年级下册", 'url':"https://v1.ykt.cbern.com.cn/65/document/d0a86fb3780b4a1f92db6025aa5683bd/pdf.pdf"},
    {'name':"数学5年级上册", 'url':"https://v1.ykt.cbern.com.cn/65/document/c07eb72ef5044b339bde311968ad3e31/pdf.pdf"},
    {'name':"数学5年级下册", 'url':"https://v1.ykt.cbern.com.cn/65/document/00149c6d79044fa08e7d03f78cdb4145/pdf.pdf"},
    {'name':"数学6年级上册", 'url':"https://v1.ykt.cbern.com.cn/65/document/b1950c9c9dcc43919f60824c1b258b06/pdf.pdf"},
    {'name':"数学6年级下册", 'url':"https://v2.ykt.cbern.com.cn/65/document/9547d96598ec4966876698c225bcfd11/pdf.pdf"}
]

for book in book_list:
    # print(book['name'], book['url'])
    command = f"wget {book['url']} -O {book['name']}.pdf"
    print(command)
    os.system(command)

```



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

