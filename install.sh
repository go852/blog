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

# hexo-generator-search: 本地搜索
# hexo-deployer-git: 一键部署到github服务器
# hexo-deployer-rsync: 一键部署到ssh服务器
# hexo-filter-mathjax: 数学公式解析
# hexo-renderer-pandoc: 渲染
# hexo-renderer-pug: butterfly主题渲染
# hexo-renderer-stylus
# hexo-theme-butterfly
# hexo-theme-stellar 
if [ -f package.json ] ; then
  modules=$(awk -F '[":]' '/^.*"hexo.*":/{print $2}' package.json)
fi

echo "\$modules: $modules"
echo

pages="about categories tags"

case $1 in
i | in | install )
  #echo npm install
  #npm install
  echo npm install $modules --save
  npm install $modules --save
  for page in pages; do
    echo hexo new page $page
    hexo new page $page
  done
  ;;
u | un | uninstall )
  rm -rf node_modules
  ;;
*)
  help
  ;;
esac

npm ls
