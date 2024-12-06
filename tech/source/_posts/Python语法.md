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

