#!/bin/bash

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

npm config set registry https://registry.npm.taobao.org 

modules="
  hexo-theme-butterfly
  hexo-theme-stellar 
  hexo-filter-mathjax 
  hexo-renderer-pandoc 
  hexo-renderer-pug
  hexo-renderer-stylus
  hexo-deployer-git
  hexo-deployer-rsync
"

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


[[ -f source/_posts/hello-world.md ]] && rm -f source/_posts/hello-world.md
