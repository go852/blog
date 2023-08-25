---
title: QQ音乐下载及转换
categories:
  - [QQ音乐]
tags:
  - [QQ音乐]
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

## 格式转换qmc2flac（解密）

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
#!/bin/bash

usage() {
  while getopts ":s:t:" opt; do
    case $opt in
    s)
      echo "source: $OPTARG"
      source=$OPTARG
      ;;
    t)
      echo "target: $OPTARG"
      target=$OPTARG
      ;;
    \?)
      echo "无效参数：-$OPTARG" >&2
      exit 1
      ;;
    esac
  done
  
  shift $((OPTIND -1)) 
  
  if [[ (-z "$source") || ( -z "$target") ]] ; then
    echo "使用说明："
    echo "  $0 -s 源目录 -t 目标目录"
    echo
    exit 1
  fi
}

process_dir(){
  PWD="$(pwd)"
  if [[ "${source:0:1}" != "/" ]]; then
    source="$PWD/$source"
  fi
  if [[ "${target:0:1}" != "/" ]]; then
    target="$PWD/$target"
  fi
  
  cd $source
  for d in *; do
    if [ -d "$d" ] ; then
      echo "处理目录：$d"
      dest="$target/$d"
      if [ ! -d "$dest" ] ; then mkdir -p "$dest"; fi
      cd $d
      takiyasha --np *.qmcflac -d "$dest"
      cd -
    fi
  done
  cd -
}

usage $*
process_dir
```

执行命令：

```bash
# cd /Volumes/Data/音乐
./qmc2flac.sh qmcflac flac
```

## 格式转换

使用xld进行格式转换

```bash
brew install xld
```

### 转换脚本flac2aac.sh

```bash
#!/bin/sh

format="aac"
ext="m4a"

usage() {
  while getopts ":f:s:t:" opt; do
    case $opt in
    f)
      echo "format: $OPTARG"
      format=$OPTARG
      ;;      
    s)
      echo "source: $OPTARG"
      source=$OPTARG
      ;;
    t)
      echo "target: $OPTARG"
      target=$OPTARG
      ;;
    \?)
      echo "无效参数：-$OPTARG" >&2
      exit 1
      ;;
    esac
  done
  
  shift $((OPTIND -1)) 
  
  if [[ (-z "$source") || ( -z "$target") ]] ; then
    echo "使用说明："
    echo "  $0 -f 格式 -s 源目录 -t 目标目录"
    echo " 格式："
    echo "    wav - wave"
    echo "    aac - m4a"
    echo "示例："
    echo "  $0 -f wav -s flac -t wav"
    echo "  $0 -f aac -s flac -t wav"
    exit 1
  fi
}


process_dir(){
  [ "$format" == "aac" ] && ext="m4a" || ext="$format"
  echo "ext:$ext"
  
  PWD="$(pwd)"
  if [[ "${source:0:1}" != "/" ]]; then
    source="$PWD/$source"
  fi
  if [[ "${target:0:1}" != "/" ]]; then
    target="$PWD/$target"
  fi
  
  cd $source
  for d in *; do
    if [ -d "$d" ] ; then
      echo "处理目录：$d"
      dest="$target/$d"
      if [ ! -d "$dest" ] ; then mkdir -p "$dest"; fi
      cd "$d"
      #takiyasha --np *.qmcflac -d "$dest"
      for f in *.flac; do
        dest_filename="$dest/${f%.flac}.$ext"
        echo xld "$f" -f aac -o "$dest_filename"
        xld "$f" -f $format -o "$dest_filename"
        echo
      done
      cd -
    fi
  done
  cd -
}

usage $*
process_dir
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

### pinpyin.py脚本

改脚本会在pyren.sh脚本调用

```pythone
#!/usr/bin/python3
import sys
from xpinyin import Pinyin

def pinyin_capitalize(str):
  p = Pinyin()
  py = p.get_pinyin(str, '@@')
  py2 = py.split('@@')
  py3 = [c.capitalize() for c in py2]
  py4 = ''.join(py3[0:])
  print(py4)
  return py4

if len(sys.argv) == 2:
  str=sys.argv[1]
  pinyin_capitalize(str)
```

### pyren.sh脚本

```python
#!/bin/sh
PINYIN="$(pwd)/pinyin.py"
usage() {
  while getopts ":e:s:t:" opt; do
    case $opt in
    e)
      echo "ext: $OPTARG"
      ext=$OPTARG
      ;;
    s)
      echo "source: $OPTARG"
      source=$OPTARG
      ;;
    t)
      echo "target: $OPTARG"
      target=$OPTARG
      ;;
    \?)
      echo "无效参数：-$OPTARG" >&2
      exit 1
      ;;
    esac
  done
  
  shift $((OPTIND -1)) 
  
  if [[ (-z "$ext") ||  (-z "$source") || ( -z "$target") ]] ; then
    echo "使用说明："
    echo "  $0 -e 扩展名 -s 源目录 -t 目标目录"
    echo "示例："
    echo "  $0 -e flac -s flac -t flac2"
    exit 1
  fi
}


process_dir(){  
  PWD="$(pwd)"
  if [[ "${source:0:1}" != "/" ]]; then
    source="$PWD/$source"
  fi
  if [[ "${target:0:1}" != "/" ]]; then
    target="$PWD/$target"
  fi
  
  cd $source
  for d in *; do
    if [ -d "$d" ] ; then
      echo "处理目录：$d"
      newd=$(python3 $PINYIN "$d")
      dest="$target/$newd"
      if [ ! -d "$dest" ] ; then mkdir -p "$dest"; fi
      cd "$d"
      for f in *.$ext; do
        f2=${f#*-}
        newname=$(python3 $PINYIN "$f2")
        dest_filename="$dest/$newname"
        echo "$f: $dest_filename"
        #echo cp "$f" "$dest_filename"
        cp "$f" "$dest_filename"
      done
      echo
      cd -
    fi
  done
  cd -
}

usage $*
process_dir
```

> ./pyren.sh -f flac -s flac -t flac2
