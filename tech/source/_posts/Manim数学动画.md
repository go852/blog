---
title: Manim数学动画
categories:
  - null
tags:
  - null
date: 2024-12-09 16:09:04
mathjax:
---

## 安装

### macOS

Intel CPU

```bash
brew install py3cairo ffmpeg
```

Apple CPU

```bash
brew install pango scipy
```

公共：

```bash
pip3 install manim
```

## 快速开始

### 圆动画

代码：

```python
from manim import *

class CreateCircle(Scene):
    def construct(self):
        circle = Circle()  # create a circle
        circle.set_fill(PINK, opacity=0.5)  # set the color and transparency
        self.play(Create(circle))  # show the circle on screen
```

生成动画：

```bash
manim -pql scene.py CreateCircle
```

