#!/bin/bash

[[ -f source/_posts/hello-world.md ]] && rm -f source/_posts/hello-world.md

help() {
  echo "
Usage:
    $0 i | install: install modules
    $0 u | uninstall: uninstall modules
"
  exit
}

if [ $# -lt 1 ]; then
  help
fi

# npm config set registry https://registry.npm.taobao.org/

# hexo-generator-search: 本地搜索需要安装此插件
modules="
  hexo-deployer-git
  hexo-deployer-rsync
  hexo-filter-mathjax 
  hexo-generator-search
  hexo-renderer-pandoc 
  hexo-renderer-pug
  hexo-renderer-stylus
  hexo-theme-butterfly
  hexo-theme-stellar 
"

if [ -f package.json ] ; then
  modules=$(awk -F '[":]' '/^.*"hexo-.*":/{print $2}' package.json)
fi

case $1 in
i | in | install )
  echo npm install
  npm install
  echo npm install $modules --save
  npm install $modules --save
  ;;
u | un | uninstall )
  rm -rf node_modules
  ;;
*)
  help
  ;;
esac

npm ls
