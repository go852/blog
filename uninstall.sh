#!/bin/bash
npm config set registry https://registry.npm.taobao.org 

modules="
  hexo-generator-archive
  hexo-generator-category
  hexo-generator-index
  hexo-generator-tag
  hexo-renderer-ejs
  hexo-renderer-stylus
  hexo-server
  hexo-theme-landscape
  hexo
  hexo-theme-stellar 
  hexo-filter-mathjax 
  hexo-renderer-pandoc 
  hexo-deployer-git
  hexo-deployer-rsync
"

for module in $modules; do
  echo npm uninstall $module --save
  npm uninstall $module --save
done
