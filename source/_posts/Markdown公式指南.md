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

## 插入公式

### 行内公式

```markdown
$ 表达式 $
```

代码`$e^{\pi \cdot i} + 1 = 0$`对应的方程显示为：$e^{\pi \cdot i} + 1 = 0$

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
E = m \cdot c^2
$$

### 自动编号

公式可以用如下方法表示：

```markdown
\begin{equation}与\end{equation}的组合，不自动编号。
```

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
    E=m \cdot c^2 \text{，自动编号公式示例}
    \label{eq:sample}
\end{equation}
$$
```

> 在公式` $\eqref{emc2}$` 中，我们看到了这个被自动编号的公式。

例子：
$$
\begin{equation}
    E=m \cdot c^2 \text{，自动编号公式示例}
    \label{emc2}
\end{equation}
$$

在公式$\eqref{emc2}$中，我们看到了这个被自动编号的公式。

###  手动编号

```markdown
\begin{equation*}与\end{equation*}的组合，不自动编号。
若需要手动编号，可在公式后使用 `\tag{编号}` 语句。
```

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
x^{y^z}=(1+{\rm e}^x)^{-2xy^w}
$$

```markdown
$$ \sideset{^1_2}{^3_4}\bigotimes \quad or \quad {^1_2}\bigotimes {^3_4} $$
```

$$
\sideset{^1_2}{^3_4}\bigotimes \quad or \quad {^1_2}\bigotimes {^3_4}
$$

## 开方

使用 `\sqrt [根指数，省略时为2] {被开方数}` 命令输入开方。
本例内 `\quad` 均为空格符号，为方便公式格式对比而添加，请注意辨别。

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
\frac{a-1}{b-1} \quad or \quad {a+1 \over b+1}
$$

## 输入括号和分隔符

|   输入    |   显示    |   输入    |   显示    |
| :-------: | :-------: | :-------: | :-------: |
| `\langle` | $\langle$ | `\rangle` | $\rangle$ |
| `\lceil`  | $\lceil$  | `\rceil`  | $\rceil$  |
| `\lfloor` | $\lfloor$ | `\rfloor` | $\rfloor$ |
| `\lbrace` | $\lbrace$ | `\rbrace` | $\rbrace$ |
| `\lvert`  | $\lvert$  | `\rvert`  | $\rvert$  |
| `\lVert`  | $\lVert$  | `\rVert`  | $\rVert$  |

```markdown
$$
markdownf(x,y,z) = 3y^2z \left( 3+\frac{7x+5}{1+y^2} \right)
$$
```

$$
f(x,y,z) = 3y^2z \left( 3+\frac{7x+5}{1+y^2} \right)
$$

```markdown
$$
xy _\text{ with arrows:} \quad \overleftarrow{xy} \; \mid \; \overleftrightarrow{xy} \; \mid \; \overrightarrow{xy}
$$
```

$$
xy _\text{ with arrows:} \quad \overleftarrow{xy} \; \mid \; \overleftrightarrow{xy} \; \mid \; \overrightarrow{xy}
$$

## 省略号

数学公式中常见的省略号有两种，`\ldots` 表示与 **文本底线** 对齐的省略号，`\cdots` 表示与 **文本中线** 对齐的省略号。

> `$$ f(x_1,x_2,\underbrace{\ldots}_{\rm ldots} ,x_n) = x_1^2 + x_2^2 + \underbrace{\cdots}_{\rm cdots} + x_n^2 $$`

$$ f(x_1,x_2,\underbrace{\ldots}_{\rm ldots} ,x_n) = x_1^2 + x_2^2 + \underbrace{\cdots}_{\rm cdots} + x_n^2 $$

## 向量

使用 `\vec{向量}` 来自动产生一个向量。也可以使用 `\overrightarrow` 等命令自定义字母上方的符号。
例内 `\quad` `\mid` `\,` 等均为空格或分隔符号，为方便公式格式对比而添加，请注意辨别。

```markdown
$$
\vec{a} \cdot \vec{b}=0
$$
```

$$
\vec{a} \cdot \vec{b}=0
$$

 

## 积分

使用 `\int_积分下限^积分上限 {被积表达式}` 来输入一个积分。

```markdown
$$ \int_0^1 {x^2} \, {\rm d}x $$
```

$$
\int_0^1 {x^2} \, {\rm d}
$$

|   输入   |   显示   |   输入    |   显示    |
| :------: | :------: | :-------: | :-------: |
|  `\int`  |  $\int$  |  `\oint`  |  $\oint$  |
| `\iint`  | $\iint$  | `\oiint`  | $\oiint$  |
| `\iiint` | $\iiint$ | `\oiiint` | $\oiiint$ |



## 运算符号

### 算术运算符

```markdown
$$
+, \, -, \, \times, \, \cdot, \, \div, \, \pm, \, \mp
$$
```

$$
+, \, -, \, \times, \, \cdot, \, \div, \, \pm, \, \mp
$$

### 关系运算符

```markdown
$$
>, \, <, \, \ge, \, \le, \, \gg. \, \ll, \, \ne, \, \approx, \, \equiv
$$
```

$$
>, \, <, \, \ge, \, \le, \, \gg. \, \ll, \, \ne, \, \approx, \, \equiv
$$

### 集合运算符

```markdown
$$
\cap, \, \cup, \, \in, \, \notin, \, \subseteq, \, \subsetneq, \, \subsetneqq, \, \varnothing
$$
```

$$
\cap, \, \cup, \, \in, \, \notin, \, \subseteq, \, \subsetneq, \, \subsetneqq, \, \varnothing
$$

### 任意、存在、不存在

```markdown
$$
\forall, \qquad \exists, \qquad \nexists
$$
```

$$
\forall, \qquad \exists, \qquad \nexists
$$

### 因为、所以

```markdown
$$
\because \qquad \therefore
$$
```

$$
\because \qquad \therefore
$$

### 数集

```markdown
有理数集、实数集、自然数集、正整数集、负整数集
$$
\mathbb Q,\qquad \R,\qquad \N,\qquad \Z_+,\qquad \Z_-
$$
```

$$
\mathbb Q,\qquad \R,\qquad \N,\qquad \Z_+,\qquad \Z_-
$$

### 累加、累乘运算

`\sum`：$\sum$

`\prod`：$\prod$

`\sum_{i=1}^n \frac{1}{i^2}`：$\sum_{i=1}^n \frac{1}{i^2}$

`\sum\limits_{i=1}^n \frac{1}{i^2}`：$\sum\limits_{i=1}^n \frac{1}{i^2}$

`\prod_{i=1}^n \frac{1}{i^2}`：$\prod_{i=1}^n \frac{1}{i^2}$

`\prod\limits_{i=1}^n \frac{1}{i^2}`：$\prod\limits_{i=1}^n \frac{1}{i^2}$

## 希腊字母

| 序号 |          国际音标          |    输入    |    显示    |    输入    |    显示    |
| :--: | :------------------------: | :--------: | :--------: | :--------: | :--------: |
|  1   |          /'ælfə/           |  `\alpha`  |  $\alpha$  |  `\Alpha`  |  $\Alpha$  |
|  2   |          /'beɪtə/          |  `\beta`   |  $\beta$   |  `\Beta`   |  $\Beta$   |
|  3   |          /'gæmə/           |  `\gamma`  |  $\gamma$  |    `\G`    |  $\Gamma$  |
|  4   |          /’dɛltə/          |  `\delta`  |  $\delta$  |  `\Delta`  |  $\Delta$  |
|  5   |         /'epsɪlɒn/         | `\epsilon` | $\epsilon$ | `\Epsilon` | $\Epsilon$ |
|  6   |          /'zi:tə/          |  `\zeta`   |  $\zeta$   |  `\Zeta`   |  $\Zeta$   |
|  7   |          /'i:tə/           |   `\eta`   |   $\eta$   |   `\Eta`   |   $\Eta$   |
|  8   |          /'θi:tə/          |  `\theta`  |  $\theta$  |  `\Theta`  |  $\Theta$  |
|  9   |         /aɪ'əʊtə/          |  `\iota`   |  $\iota$   |  `\Iota`   |  $\Iota$   |
|  10  |          /'kæpə/           |  `\kappa`  |  $\kappa$  |  `\Kappa`  |  $\Kappa$  |
|  11  |          /'læmdə/          | `\lambda`  | $\lambda$  | `\Lambda`  | $\Lambda$  |
|  12  |           /mju:/           |   `\mu`    |   $\mu$    |   `\Mu`    |   $\Mu$    |
|  13  |           /nju:/           |   `\nu`    |   $\nu$    |   `\Nu`    |   $\Nu$    |
|  14  | /ksaɪ; gzaɪ; saɪ; **zaɪ**/ |   `\xi`    |   $\xi$    |   `\Xi`    |   $\Xi$    |
|  15  |        /ˈɑmɪˌkrɑn/         | `\omicron` | $\omicron$ | `\Omicron` | $\Omicron$ |
|  16  |           /paɪ/            |   `\pi`    |   $\pi$    |   `\Pi`    |   $\Pi$    |
|  17  |           /rəʊ/            |   `\rho`   |   $\rho$   |   `\Rho`   |   $\Rho$   |
|  18  |          /'sɪɡmə/          |  `\simga`  |  $\sigma$  |  `\Sigma`  |  $\Sigma$  |
|  19  |           /taʊ/            |   `\tau`   |   $\tau$   |   `\Tau`   |   $\Tau$   |
|  20  |         /ˈipsilon/         | `\upsilon` | $\upsilon$ | `\Upsilon` | $\Upsilon$ |
|  21  |           /faɪ/            |   `\phi`   |   $\phi$   |   `\Phi`   |   $\Phi$   |
|  22  |           /kaɪ/            |   `\chi`   |   $\chi$   |   `\Chi`   |   $\Chi$   |
|  23  |      /psaɪ; **saɪ**/       |   `\psi`   |   $\psi$   |   `\Psi`   |   $\Psi$   |
|  24  |         /'əʊmɪɡə/          |  `\omega`  |  $\omega$  |  `\Omega`  |  $\Omega$  |



## 公式对齐

**说明：**

1. `{align}`：自动编号
2. `{align*}`：不自动编号
3. `&`：指定对齐位置
4. `\\`：连续2个反斜杠代表换行
5. `\\[2ex]`换行，并设置两倍行间距

```markdown
$$
\begin {align*}
& x^2+\frac{b}{a}x+\frac{c}{a}=0 \tag{1} \\[2ex]
& (x+\frac{b}{2a})^2-\frac{b^2}{4a^2}+\frac{c}{a}=0 \tag{2} \\[2ex]
& (x+\frac{b}{2a})^2=\frac{b^2-4ac}{4a^2} \tag{3} \\[2ex]
& x+\frac{b}{2a}=\pm\frac{\sqrt{b^2-4ac}}{2a} \tag{4} \\[2ex]
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
& x^2+\frac{b}{a}x+\frac{c}{a} &=0 \tag{1}\\[2ex]
& (x+\frac{b}{2a})^2-\frac{b^2}{4a^2}+\frac{c}{a} &=0 \tag{2} \\[2ex]
& (x+\frac{b}{2a})^2 &=\frac{b^2-4ac}{4a^2} \tag{3}\\[2ex]
& x+\frac{b}{2a} &=\pm\frac{\sqrt{b^2-4ac}}{2a} \tag{4}\\[2ex]
& x &=\frac{-b\pm\sqrt{b^2-4ac}}{2a} \tag{5}
\end {align*}
$$
```

$$
\begin {align*}
& x^2+\frac{b}{a}x+\frac{c}{a} &=0 \tag{1}\\[2ex]
& (x+\frac{b}{2a})^2-\frac{b^2}{4a^2}+\frac{c}{a} &=0 \tag{2} \\[2ex]
& (x+\frac{b}{2a})^2 &=\frac{b^2-4ac}{4a^2} \tag{3}\\[2ex]
& x+\frac{b}{2a} &=\pm\frac{\sqrt{b^2-4ac}}{2a} \tag{4}\\[2ex]
& x &=\frac{-b\pm\sqrt{b^2-4ac}}{2a} \tag{5}
\end {align*}
$$

