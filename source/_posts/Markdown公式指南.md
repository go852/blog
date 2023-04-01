---
title: Markdown公式指南
categories:
  - [Markdown]
tags:
  - Markdown
  - 公式
date: 2023-04-01 21:04:14
mathjax: true
---

## 公式对齐

>说明：
>
>- {align}：自动编号
>- {align*}：不自动编号
>- &：指定对齐位置
>- \\\\：连续2个反斜杠代表换行

```markdown
$$
\begin {align*}
& x^2+\frac{b}{a}x+\frac{c}{a}=0 \tag{1}\\\\
& (x+\frac{b}{2a})^2-\frac{b^2}{4a^2}+\frac{c}{a}=0 \tag{2} \\\\
& (x+\frac{b}{2a})^2=\frac{b^2-4ac}{4a^2} \tag{3}\\\\
& x+\frac{b}{2a}=\pm\frac{\sqrt{b^2-4ac}}{2a} \tag{4}\\\\
& x=\frac{-b\pm\sqrt{b^2-4ac}}{2a} \tag{5}
\end {align*}
$$
```

$$
\begin {align*}
& x^2+\frac{b}{a}x+\frac{c}{a}=0 \tag{1}\\\\
& (x+\frac{b}{2a})^2-\frac{b^2}{4a^2}+\frac{c}{a}=0 \tag{2} \\\\
& (x+\frac{b}{2a})^2=\frac{b^2-4ac}{4a^2} \tag{3}\\\\
& x+\frac{b}{2a}=\pm\frac{\sqrt{b^2-4ac}}{2a} \tag{4}\\\\
& x=\frac{-b\pm\sqrt{b^2-4ac}}{2a} \tag{5}
\end {align*}
$$

