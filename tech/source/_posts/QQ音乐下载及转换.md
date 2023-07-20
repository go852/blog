---
title: QQ音乐下载及转换
categories:
  - null
tags:
  - null
date: 2023-07-17 16:37:13
mathjax:
---

## QQ音乐下载

mac版：[QQ音乐7.2.0.3](https://www.xue51.com/mac/61958.html#xzdz)

## 破解软件下载

```bash
pip3 install -U takiyasha
```

## QQ音乐下载目录

``` bash 
cd "/Users/paul/Library/Containers/com.tencent.QQMusicMac/Data/Library/Application Support/QQMusicMac/iQmc" 
```

<!--more-->

## 格式转换qmcflac2flac（解密）

```bash
takiyash *.qmcflac
```

> 参数说明：
>
>  -d DESTPATH, --dest DESTPATH
>
> ​            将所有输出文件放置在指定目录下；
>
> ​            与 '--ds, --dest-source' 冲突
>
>  --ds, --dest-source  将每一个输出文件放置在源文件所在目录下；
>
> ​            与 '-d, --dest' 冲突
>
>  -r, --recursive    如果 PATH 中存在目录，那么递归处理目录下的文件
>
> ​            （不包括子目录）
>
>  --np, --no-parallel  不使用并行模式
>
>  -t, --test      仅测试输入文件是否受支持，不进行解密
>
>  -q, --quiet      不显示任何信息，仅根据退出状态码表示运行结果



不使用并行模式，指定输出文件夹转换：

```bash
takiyasha --np *.qmcflac -d /Volumes/Data/flac/
```

### 转换脚本qmc2flac.sh

```bash
#!/bin/sh

if [ $# -lt 1 ] ; then
  echo "使用说明："
  echo "  $0 目标目录"
  echo
  exit 0
fi

dest=$1

for d in *; do
  if [ -d "$d" ] ; then
    echo "处理目录：$d"
    target="$dest/$d"
    if [ ! -d "$target" ] ; then mkdir -p "$target"; fi
    cd $d
    takiyasha --np *.qmcflac -d "$target"
    cd -
  fi
done
```

执行命令：

```bash
./qmc2flac.sh /Volumes/Data/flac
```

## 格式转换flac2wav

使用xld进行格式转换

```bash
brew install xld
```

### 转换脚本flac2wav.sh

```bash
#!/bin/sh
if [ $# -lt 1 ] ; then
  echo "使用说明："
  echo "  $0 源目录 目标目录"
  echo
  exit 0
fi

echo '$1:' $1
src=$(realpath "$1")
dest=$(realpath "$2")

echo $src
echo $dest

cd "$src"
for d in *; do
  if [ -d "$d" ]; then
    echo "处理目录：$d"
    target="$dest/$d"
    if [ ! -d "$target" ] ; then mkdir -p "$target"; fi
    cd "$d"
    for f in *.flac; do
      target_filename="$target/${f%.flac}.wav"
      echo xld "$f" -f wav -o "$target_filename"
      xld "$f" -f wav -o "$target_filename"
      echo
    done
    cd -
    echo
  fi
done
cd -
```

### 转换脚本flac2aac.sh

```bash
#!/bin/sh
if [ $# -lt 1 ] ; then
  echo "使用说明："
  echo "  $0 源目录 目标目录"
  echo
  exit 0
fi

echo '$1:' $1
src=$(realpath "$1")
dest=$(realpath "$2")

echo $src
echo $dest

cd "$src"
for d in *; do
  if [ -d "$d" ]; then
    echo "处理目录：$d"
    target="$dest/$d"
    if [ ! -d "$target" ] ; then mkdir -p "$target"; fi
    cd "$d"
    for f in *.flac; do
      target_filename="$target/${f%.flac}.m4a"
      echo xld "$f" -f aac -o "$target_filename"
      xld "$f" -f aac -o "$target_filename"
      echo
    done
    cd -
    echo
  fi
done
cd -
```

## 删除已转换的文件

```bash
# find带-print0参数，xargs带-0参数是为了处理包含有空白符的文件名。
find . -name *.wav -print0 | xargs -0 echo && rm -f
```

## 将中文文件名改为拼音文件名

> 安装xpinyin模块
>
> python3 pyren.py

### pyren.py脚本

```python
#/usr/bin/python

def pinyin_capitalize(str):
    from xpinyin import Pinyin
    p = Pinyin()
    py = p.get_pinyin(str, '@@')
    py2 = py.split('@@')
    py3 = [c.capitalize() for c in py2]
    py4 = ''.join(py3[0:])
    return py4

def rename_pinyin(folder='/Volumes/Data/flac'):
    import os
    import re
    curdir = os.getcwd()
    os.chdir(folder)
    print("Processing ", folder, "...")

    file_list = [f for f in os.listdir() if not f.startswith('.')
                if f !='script']
    for count, f in enumerate():
        if f[0] == '.':
            continue
        filename = re.sub(r'[0-9]+\.', '',  f)
        filename = str(count).zfill(3) + '.' + pinyin_capitalize(filename) #
        if os.path.isdir(f):
            print("rename ", f, filename)
            os.rename(f, filename)
            rename_pinyin(folder = folder + '/' + filename)
        else:
            name, ext = os.path.splitext(filename)
            e = ext.lower()
            if e.endswith("flac") or e.endswith("wav") or e.endswith("m4a"):
                print("rename ", f, filename)
                os.rename(f, filename)
    os.chdir(curdir)

import sys
rename_pinyin(sys.argv[1])

```

> python3 pyren.py "/Volumes/Data/flac"
