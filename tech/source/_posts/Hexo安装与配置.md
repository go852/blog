---
title: Hexo安装与配置
date: 2023-03-31 09:19:34
tags: [网站设计,Hexo] # 用","分隔不同的标签
categories: [网站设计,Hexo] # 用","分隔分类与子类
---
## 安装Node.js

1. 安装Node.js（19.x）包括npm
2. 设置国内镜像源

### Ubuntu

```bash
curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash - && sudo apt-get install -y nodejs
```

### macOS

```bash
VERSION=v20.6.1
wget https://nodejs.org/dist/$VERSION/node-$VERSION.pkg
sudo installer -verbose -pkg node-$VERSION.pkg -target /

```

<!--more-->

<img src="image-20230329111958138.jpg" alt="image-20230329111958138" style="zoom:100%;" />



### 设置NPM国内镜像源

```bash
npm config set registry https://registry.npm.taobao.org 
```

或：

```bash
npm config set registry https://registry.npmmirror.com
```

使用以下命令可以查看npm的设置信息：

```bash
npm config list
```

删除镜像源：

```bash
npm config delete registry
```

## 安装Hexo

```bash
sudo npm install -g hexo-cli
```

## 建立站点

```bash
hexo init blog
cd blog
hexo server
```

建立站点也可以用以下方式进行：

```bash
git clone https://github.com/hexojs/hexo-starter.git blog
cd blog
npm install
```



### 测试站点

<img src="image-20230330120820110.jpg" alt="image-20230330120820110" style="zoom:100%;"/>

### 生成器

生成器能够生成静态文件。

```bash
hexo generate
```



### 清理缓存及静态文件

```bash
hexo clean
```



## 配置站点

### 安装主题

1. 安装主题（可以通过npm install hexo-theme-name或者git clone URL的方式安装）
2. 复制主题配置文件到站点，将主题目录的`_config.yml`复制到站点：`_config.theme_name.yml`文件。
3. 测试站点：`hexo clean ; hexo server --watch`

**推荐主题：**

1. [Next](https://github.com/next-theme/hexo-theme-next)
2. [Butterfly](https://github.com/jerryc127/hexo-theme-butterfly)
3. [Stellar](https://github.com/xaoxuu/hexo-theme-stellar)
4. [Keep](https://github.com/XPoet/hexo-theme-keep)
5. [Free2mind](https://github.com/rudy-yuan/free2mind)
6. [Polk](https://github.com/chunqiuyiyu/hexo-theme-polk)
7. [Ringo](https://github.com/HeliumOI/hexo-theme-ringo)
8. [Xups](https://github.com/jangdelong/hexo-theme-xups)

**执行以下命令：**

```bash
npm install hexo-theme-next
hexo config theme next
hexo clean && hexo server --watch
```

### 修改站点配置文件

> _config.yml文件：

```yaml
post_asset_folder: true 
# true: 新建文章将创建于文章名称相同的目录，文章保存在该目录下的index.md文件，插入本地图像打开次选项
# false: 不创建目录，文章直接保存在source/_post/目录下，文件名为"文章名称.md"
```



### 修改模板

最好的办法是在模板上设置

Scaffolds/post.md:

Scaffolds/draft.md:

```markdown
---
title: {{ title }}
date: {{ date }}
categories: [] # 用,分隔分类与子类
tags: [] # 用|分隔不同的标签
mathjax: 
---
```

Scaffolds/page.md:

```markdown
---
title: {{ title }}
date: {{ date }}
mathjax:
---
```

### 新建页面

页面保存路径：source/页面名称/index.md，如：about，则为：source/about/index.md

```bash
hexo new page about
```



### 新建文章

文章保存目录：source/\_post/，如：一元二次方程求根公式，则为："source/\_post/一元二次方程求根公式.md"

```bash
hexo new 一元二次方程求根公式
```

编辑站点配置文件：_config.yml

```
title: 852us
subtitle: 程序设计|中小学教育
description: 专注于C语言、Python语言程序设计与中小学教育
keywords: C语言,Python语言,程序设计,中小学教育
author: 852us
language: zh-CN
timezone: Asia/Shanghai
url: http://edu.852us.com/
```

修改文章模板文件：scaffolds/post.md

```md
---
title: {{ title }}
date: {{ date }}
tags: [] # 用|分隔不同的标签
categories: [] # 用,分隔分类与子类
mathjax: 
---
```

### 数学公式

#### 安装需要的包

安装hexo-filter-mathjax、pandoc渲染包，删除hexo-math、hexo-renderer-marked包

```bash
npm uninstall hexo-math --save
npm uninstall hexo-renderer-marked  --save

npm install hexo-filter-mathjax --save
npm install hexo-renderer-pandoc --save
```

### 插入图片

```markdown
<img src="image.jpg" alt="image" style="zoom:100%;"/>
```

post_asset_folder为true时，image.jpg与文章保存在同一个目录下。

## 部署服务器

### Git

**安装模块**

```bash
npm install hexo-deployer-git --save
```

**编辑站点配置文件**

```yaml
deploy:
- type: git
  repo: git@github.com:852us/852us.github.io.git
  branch: main
```

需要在github网站上用户设置增加SSH Key。

**测试与github的连接**

```bash
ssh -T git@github.com
```

输出结果如下为连接正常。

> Hi 852us! You've successfully authenticated, but GitHub does not provide shell access.



### Rsync

**安装模块**

```bash
npm install hexo-deployer-rsync --save
```

**编辑站点配置文件**

```yaml
deploy:
- type: rsync
  host: 852us.com
  user: ubuntu
  root: /var/edu # 服务器https服务根目录
  port: 22
  delete: true
  verbose: true
  ignore_errors: false
```



## 快速创建edu博客

```bash
git clone https://github.com/852us/edu
cd edu
./install.sh i
hexo clean && hexo server --watch
```



### 模块说明

#### hexo-renderer-pandoc

使用该模块，需要额外安装pandoc。

```
brew install pandoc
```

