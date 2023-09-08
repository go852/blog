---
title: Python
categories:
  - [程序设计, Python]
tags:
  - 程序设计
  - Python
date: 2023-06-17 19:16:22
mathjax:
---



## DataFrame

### 创建DataFrame对象

```python
import pandas as pd
import numpy as np
df = pd.DataFrame(np.random.random((3, 5)))
df.columns = ['a', 'b', 'c', 'd', 'e']
print(df)
```

运行结果：

```
          a         b         c         d         e
0  0.493908  0.129874  0.715260  0.725369  0.994077
1  0.021717  0.369733  0.070762  0.940723  0.637749
2  0.201970  0.075588  0.103985  0.706798  0.635883
```

### 访问DF对象的列

```python
print(df.columns)
print(df.columns.tolist())
```

运行结果：

```
Index(['a', 'b', 'c', 'd', 'e'], dtype='object')
['a', 'b', 'c', 'd', 'e']
```

### 访问DF对象的索引

```python
print(df.index)
```

运行结果：

```
RangeIndex(start=0, stop=3, step=1)
```

<!--more-->

### 删除行

```python
df = df.drop(index=[0, 1, 2]) # 删除第0-2行
print(df)
```

运行结果：

```
Empty DataFrame
Columns: [a, b, c, d, e]
Index: []
```

### 创建空对象

```python
df2 = pd.DataFrame(data=None, columns=['Name', 'Birthday', 'Address'])
print("df2:", df2)
```

运行结果：

```
df2: Empty DataFrame
Columns: [Name, Birthday, Address]
Index: []
```

### 打印完整数据

```python
# display.max_rows的默认值是10
# display.max_columns的默认值是10
klines = self.api.get_kline_serial(self.symbols, 60, data_length=5)
with pd.option_context('display.max_rows', None, 
                       'display.max_columns', None,
                       'display.width', None,
                       'display.max_colwidth', None
                       ):
    print(klines)
```

方式二、

```python
# Permanently changes the pandas settings
pd.set_option('display.max_rows', None)
pd.set_option('display.max_columns', None)
pd.set_option('display.width', None)
pd.set_option('display.max_colwidth', None)

klines = self.api.get_kline_serial(self.symbols, 60, data_length=5)
print(klines)
```

运行结果：

```
       datetime       id    open    high     low   close  volume  open_oi  close_oi     symbol  duration
0  1.687141e+18  62033.0  2182.5  2183.0  2181.5  2182.5    51.0  47595.0   47585.0  DCE.j2309        60
1  1.687141e+18  62034.0  2182.5  2182.5  2180.0  2181.0    67.0  47585.0   47614.0  DCE.j2309        60
2  1.687141e+18  62035.0  2181.0  2181.0  2178.0  2178.0   165.0  47614.0   47622.0  DCE.j2309        60
3  1.687141e+18  62036.0  2178.0  2180.0  2177.5  2180.0   104.0  47622.0   47580.0  DCE.j2309        60
4  1.687141e+18  62037.0  2180.0  2182.0  2180.0  2182.0    80.0  47580.0   47581.0  DCE.j2309        60
```

