#!/bin/bash
echo "🔄 升级 Hexo 到版本 8"
echo "===================="

echo "当前 Hexo 版本:"
hexo version

echo ""
echo "开始升级..."

# 卸载旧版本
npm uninstall hexo hexo-cli

# 安装新版本
npm install hexo@8.0.0 hexo-cli --save

# 更新其他依赖到兼容版本
npm install hexo-generator-archive@2.0.0 --save
npm install hexo-generator-category@2.0.0 --save  
npm install hexo-generator-index@4.0.0 --save
npm install hexo-generator-tag@2.0.0 --save
npm install hexo-renderer-marked@7.0.1 --save
npm install hexo-renderer-stylus@3.0.1 --save
npm install hexo-server@3.0.0 --save

echo ""
echo "升级后的版本:"
hexo version

echo ""
echo "更新后的 package.json:"
cat package.json | grep -A 2 '"hexo"'
