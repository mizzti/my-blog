#!/bin/bash
# 部署脚本配置
BLOG_DIR="/d/blog"
GIT_BRANCH="master"
DEPLOY_MESSAGE="自动部署: $(date +'%Y-%m-%d %H:%M:%S')"
echo "🚀 开始博客部署流程..."
echo "========================================"
cd "$BLOG_DIR" || exit 1
echo "📁 当前目录: $(pwd)"
echo "========================================"
# 步骤1: 清理和生成静态文件
echo "1️⃣ 步骤1: 清理和生成静态文件..."
echo "----------------------------------------"
hexo clean
hexo generate
echo "✅ 静态文件生成完成"
echo ""
# 步骤2: 提交到Git
echo "2️⃣ 步骤2: 提交到Git..."
echo "----------------------------------------"
git add .
git commit -m "$DEPLOY_MESSAGE"
git push origin "$GIT_BRANCH"
echo "✅ 代码已推送到GitHub"
echo "🎉 部署完成！等待自动构建..."
echo "🌐 访问: https://leblog.top"
