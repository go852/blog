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
wget https://nodejs.org/dist/v19.8.1/node-v19.8.1.pkg
sudo installer -verbose -pkg node-v19.8.1.pkg -target /
```

<img src="image-20230329111958138.jpg" alt="image-20230329111958138" style="zoom:100%;" />

## 设置NPM国内镜像源

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

## 一键建站

```bash
hexo init blog # 建立站点
cd blog
hexo server
```

建立站点也可以用以下方式进行：

```bash
git clone https://github.com/hexojs/hexo-starter.git blog
cd blog
npm install
```

### 浏览站点（测试）

<img src="image-20230330120820110.jpg" alt="image-20230330120820110" style="zoom:100%;"/>

## 配置站点

### 推荐主题

1. [Free2mind](https://github.com/rudy-yuan/free2mind)
2. [Next](https://github.com/next-theme/hexo-theme-next)
3. [Polk](https://github.com/chunqiuyiyu/hexo-theme-polk)
4. [Ringo](https://github.com/HeliumOI/hexo-theme-ringo)
5. [Stellar](https://github.com/xaoxuu/hexo-theme-stellar)
6. [Xups](https://github.com/jangdelong/hexo-theme-xups)

#### NexT

```bash
git clone https://github.com/next-theme/hexo-theme-next themes/next
npm install hexo-theme-next
hexo config theme next
hexo clean && hexo generate -d && hexo server --watch
```

#### Ringo

```bash
git clone https://github.com/HeliumOI/hexo-theme-ringo themes/ringo
hexo config theme ringo
hexo clean && hexo generate -d && hexo server --watch
```

#### Stellar

```bash
git clone https://github.com/xaoxuu/hexo-theme-stellar themes/stellar
npm install hexo-theme-stellar
hexo config theme stellar
hexo clean && hexo generate -d && hexo server --watch
```

### 设置站点Front-matter

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

### 新建文章（海报）

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

修改文章（海报）模板文件：scaffolds/post.md

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

安装hexo-filter-mathjax、kramed包，删除hexo-math、hexo-renderer-marked包

```bash
npm uninstall hexo-math --save
npm install hexo-filter-mathjax --save
npm uninstall hexo-renderer-marked  --save
npm install hexo-renderer-pandoc --save
```

### 插入图片

修改站点配置文件：_config.yml

```bash
marked:
  prependRoot: true
  postAsset: true
```

### 修改站点配置文件

```yaml
marked:
  prependRoot: true
  postAsset: true
```

## 部署服务器

### Git

安装模块hexo-deployer-git

```bash
npm install hexo-deployer-git --save
```

编辑站点配置文件：_config.yml

```yaml
deploy:
- type: git
  repo: git@github.com:852us/852us.github.io.git
  branch: main
```

需要在github网站上用户设置增加SSH Key。

#### 测试与github的连接

```bash
ssh -T git@github.com
```

输出结果如下为连接正常。

> Hi 852us! You've successfully authenticated, but GitHub does not provide shell access.



### Rsync

安装模块hexo-deployer-rsync

```bash
npm install hexo-deployer-rsync --save
```

编辑站点配置文件：_config.yml

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

## 从服务器创建blog

```bash
git clone https://github.com/852us/edu
cd edu
./install.sh i
hexo server --watch
```
