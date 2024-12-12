---
title: Manim数学动画
categories:
  - [数学]
  - [Python]
  - [Manim]
tags:
  - 数学
  - Python
  - Manim
date: 2024-12-09 16:09:04
mathjax:
---

## 安装

### macOS

```bash
brew install python3 manim
```

## 快速开始

### 圆动画

代码：Circle.py

```python
from manim import *

class CreateCircle(Scene):
    def construct(self):
        circle = Circle()  # create a circle
        circle.set_fill(PINK, opacity=0.5)  # set the color and transparency
        self.play(Write(Text("Draw a circle with PINK color.")))
        self.play(Create(circle))  # show the circle on screen
```

生成动画：

```bash
manim -pql Circle.py CreateCircle
```

>Manim Community v0.18.1
>
>
>
>[12/09/24 18:12:36] INFO   Animation 0 : Partial movie file written in '/Users/paul/Desktop/BaiduNetdisk/01 scene_file_writer.py:527
>
>​               NOI/04数学动画/media/videos/Circle/480p15/partial_movie_files/CreateCircle/118581             
>
>​               8338_41213021_223132457.mp4'                                        
>
>​          INFO   Combining to Movie file.                             scene_file_writer.py:617
>
>​          INFO                                            scene_file_writer.py:737
>
>​               **File** ready at '/Users/paul/Desktop/BaiduNetdisk/01                             
>
>​               NOI/04数学动画/media/videos/Circle/480p15/CreateCircle.mp4'                        
>
>​                                                                    
>
>​          INFO   **Rendered** CreateCircle                                     scene.py:247
>
>​               **Played** 1 **animations**                                            
>
>​          INFO   Previewed **File** at: '/Users/paul/Desktop/BaiduNetdisk/01                  file_ops.py:231
>
>​               NOI/04数学动画/media/videos/Circle/480p15/CreateCircle.mp4' 

### Manim 命令行参数

```bash
manim --help
manim render --help
```

>--format [png|gif|mp4|webm|mov]
>
>-p --preview: 完成后播放场景动画
>
>-r --resolution: Resolution in "W,H" for when 16:9 aspect ratio isn't possible.
>
>-q, --quality [l|m|h|p|k]   Render quality at the follow resolution framerates, respectively: 
>
>​	【l】854x480 15FPS, 【m】1280x720 30FPS, 【h】1920x1080 60FPS, 【p】2560x1440 60FPS, 【k】3840x2160 60FPS
>
>--fps, --frame_rate FLOAT   Render at this frame rate.
