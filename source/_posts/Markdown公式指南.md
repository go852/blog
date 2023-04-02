---
title: Markdown公式指南
categories:
  - [网站设计,Markdown]
tags:
  - Markdown
  - 公式
date: 2023-04-01 21:04:14
mathjax: true
---

<!-- toc -->



## 插入公式

### 行内公式

```markdown
$ 表达式 $
```

<div>
  `$e^{\pi \cdot i} + 1 = 0$` <br>
  $e^{\pi \cdot i} + 1 = 0$
</div>

### 独立公式

```markdown
$$ 表达式 $$
```

```markdown
$$
E = m \cdot c^2
$$
```

$$
\begin{equation*}
E = m \cdot c^2
\end{equation*}
$$

### 自动编号

公式可以用如下方法表示：

```markdown
$$
\begin{equation}
    表达式
    \label{eq:当前公式名}
\end{equation}
$$
```

自动编号后的公式可在全文任意处使用 `\eqref{eq:公式名} `语句引用。

```markdown
$$
\begin{equation}
    E=mc^2 \text{，自动编号公式示例}
    \label{eq:sample}
\end{equation}
$$
```

> 在公式` $\eqref{emc2}$` 中，我们看到了这个被自动编号的公式。

例子：
$$
\begin{equation}
    E=mc^2 \text{，自动编号公式示例}
    \label{emc2}
\end{equation}
$$

在公式$\eqref{emc2}$中，我们看到了这个被自动编号的公式。

###  手动编号

若需要手动编号，可在公式后使用 `\tag{编号}` 语句。

```markdown
$$
\begin{equation*}
E = m \cdot c^2 \qquad \text{手动编号} \tag{a}
\end{equation*}
$$
```

$$
\begin{equation*}
E = m \cdot c^2 \qquad \text{手动编号} \tag{a}
\end{equation*}
$$



## 上下标

`^` 表示上标，`_` 表示下标。如果上下标的内容多于一个字符，需要用 `{}` 将这些内容括成一个整体。
上下标可以嵌套，也可以同时使用。

```markdown
$$ x^{y^z}=(1+{\rm e}^x)^{-2xy^w} $$
```

$$
\begin{equation*}
x^{y^z}=(1+{\rm e}^x)^{-2xy^w}
\end{equation*}
$$

```markdown
$$ \sideset{^1_2}{^3_4}\bigotimes \quad or \quad {^1_2}\bigotimes {^3_4} $$
```

$$
\sideset{^1_2}{^3_4}\bigotimes \quad or \quad {^1_2}\bigotimes {^3_4}
$$



## 开方

使用 `\sqrt [根指数，省略时为2] {被开方数}` 命令输入开方。
本例内 `\quad` 均为空格符号，为方便公式格式对比而添加，请注意辨别。详见[在字符间加入空格](# 3在字符间加入空格)。

```markdown
$$ \sqrt{2} \quad or \quad \sqrt[n]{3} $$
```

$$
\sqrt{2} \quad or \quad \sqrt[n]{3}
$$



## 分数

通常使用 `\frac {分子} {分母}` 来生成一个分数，分数可多层嵌套。
若分数只有一层，也可使用 `分子 \over 分母` 命令。
例内 `\quad` `\mid` `\,` 等均为空格或分隔符号，为方便公式格式对比而添加，请注意辨别。详见[在字符间加入空格](# 3在字符间加入空格)。

```markdown
$$ \\frac{a-1}{b-1} \quad or \quad {a+1 \over b+1} $$
```

$$
\begin{equation*}
\frac{a-1}{b-1} \quad or \quad {a+1 \over b+1}
\end{equation*}
$$

## 公式对齐

说明：

1. `{align}`：自动编号
2. `{align*}`：不自动编号
3. `&`：指定对齐位置
4. `\\`：连续2个反斜杠代表换行

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
& x^2+\frac{b}{a}x+\frac{c}{a}=0 \tag{1} \\[2ex]
& (x+\frac{b}{2a})^2-\frac{b^2}{4a^2}+\frac{c}{a}=0 \tag{2} \\[2ex]
& (x+\frac{b}{2a})^2=\frac{b^2-4ac}{4a^2} \tag{3} \\[2ex]
& x+\frac{b}{2a}=\pm\frac{\sqrt{b^2-4ac}}{2a} \tag{4} \\[2ex]
& x=\frac{-b\pm\sqrt{b^2-4ac}}{2a} \tag{5}
\end {align*}
$$


### 二级对齐

```markdown
$$
\begin {align*}
& x^2+\frac{b}{a}x+\frac{c}{a} &=0 \tag{1}\\\\
& (x+\frac{b}{2a})^2-\frac{b^2}{4a^2}+\frac{c}{a} &=0 \tag{2} \\\\
& (x+\frac{b}{2a})^2 &=\frac{b^2-4ac}{4a^2} \tag{3}\\\\
& x+\frac{b}{2a} &=\pm\frac{\sqrt{b^2-4ac}}{2a} \tag{4}\\\\
& x &=\frac{-b\pm\sqrt{b^2-4ac}}{2a} \tag{5}
\end {align*}
$$
```

$$
\begin {align*}
& x^2+\frac{b}{a}x+\frac{c}{a} &=0 \tag{1}\\\\
& (x+\frac{b}{2a})^2-\frac{b^2}{4a^2}+\frac{c}{a} &=0 \tag{2} \\\\
& (x+\frac{b}{2a})^2 &=\frac{b^2-4ac}{4a^2} \tag{3}\\\\
& x+\frac{b}{2a} &=\pm\frac{\sqrt{b^2-4ac}}{2a} \tag{4}\\\\
& x &=\frac{-b\pm\sqrt{b^2-4ac}}{2a} \tag{5}
\end {align*}
$$

