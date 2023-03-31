#!/bin/bash

if [ $# -lt 1 ]; then
  echo "
Usage:
    $0 i | install: install modules
    $0 u | uninstall: uninstall modules
"
    exit
fi

npm config set registry https://registry.npm.taobao.org 

modules="
  hexo-theme-stellar 
  hexo-filter-mathjax 
  hexo-renderer-pandoc 
  hexo-deployer-git
  hexo-deployer-rsync
"

for module in $modules; do
  case $1 in
  i | install )
    echo npm install $module --save
    npm install $module --save
    ;;
  u | uninstall )
    echo npm uninstall $module --save
    npm uninstall $module --save
  ;;
  esac
done
