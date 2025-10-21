#!/bin/bash

# 部署脚本配置
BLOG_DIR="/d/blog"
GIT_BRANCH="main"
DEPLOY_MESSAGE="自动部署: $(date +'%Y-%m-%d %H:%M:%S')"

# 域名配置 - 根据你的实际信息更新
NETLIFY_DOMAIN="cheery-horse-aa0c34.netlify.app"
CLOUDFLARE_DOMAIN="my-blog-bv6.pages.dev"
MAIN_DOMAIN="leblog.top"

echo "🚀 开始博客部署流程..."
echo "========================================"

# 检查是否在正确的目录
if [ ! -d "$BLOG_DIR" ]; then
    echo "❌ 错误: 博客目录不存在: $BLOG_DIR"
    exit 1
fi

cd "$BLOG_DIR"

echo "📁 当前目录: $(pwd)"
echo "========================================"

# 步骤1: 清理和生成静态文件
echo "1️⃣ 步骤1: 清理和生成静态文件..."
echo "----------------------------------------"
hexo clean
if [ $? -ne 0 ]; then
    echo "❌ Hexo清理失败!"
    exit 1
fi

hexo generate
if [ $? -ne 0 ]; then
    echo "❌ Hexo生成失败!"
    exit 1
fi
echo "✅ 静态文件生成完成"
echo ""

# 步骤2: 检查Git状态
echo "2️⃣ 步骤2: 检查Git状态..."
echo "----------------------------------------"
git status
echo ""

# 步骤3: 添加到Git
echo "----------------------------------------"
git add .
if [ $? -ne 0 ]; then
    echo "❌ Git添加文件失败!"
    exit 1
fi

# 检查是否有更改需要提交
    git commit -m "$DEPLOY_MESSAGE"
    if [ $? -ne 0 ]; then
        echo "❌ Git提交失败!"
        exit 1
    fi
    echo "✅ 更改已提交: $DEPLOY_MESSAGE"
fi
echo ""

# 步骤4: 推送到GitHub
echo "4️⃣ 步骤4: 推送到GitHub..."
echo "----------------------------------------"
git push origin "$GIT_BRANCH"
if [ $? -ne 0 ]; then
    echo "❌ Git推送失败!"
    exit 1
fi
# 步骤5: 显示部署信息
echo "🎉 部署流程完成!"
echo "========================================"
echo "📊 部署摘要:"
echo "   ✅ Hexo静态文件已生成"
echo "   ✅ 代码已提交到Git"
echo "   ✅ 代码已推送到GitHub"
echo ""
echo "🚀 自动构建触发:"
echo "   • Netlify - 自动开始构建"
echo "   • Cloudflare Pages - 自动开始构建"
echo ""
echo "⏰ 预计等待时间: 2-5分钟"
echo "🌐 部署完成后访问:"
echo "   • https://${NETLIFY_DOMAIN}"
echo "   • https://${CLOUDFLARE_DOMAIN}" 
echo "   • https://${MAIN_DOMAIN} (主域名)"
echo ""
echo "📋 查看构建状态:"
echo "   • Netlify: https://app.netlify.com/sites/cheery-horse-aa0c34/deploys"
echo "   • Cloudflare: https://dash.cloudflare.com/"
echo "========================================"
echo "💡 提示: 所有平台会自动构建，无需手动操作"echo "✅ 代码已推送到GitHub分支: $GIT_BRANCH"
echo ""

if git diff-index --quiet HEAD --; then
    echo "📝 没有检测到文件更改，跳过提交"
else

