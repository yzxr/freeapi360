#!/bin/bash

# DeRouter Clone - 快速部署脚本
# 创建时间：2026-04-09

set -e

echo "🚀 DeRouter Clone - 快速部署脚本"
echo "=================================="
echo ""

# 检查 Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Node.js 未安装，请先安装 Node.js 18+"
    exit 1
fi

echo "✅ Node.js 版本：$(node -v)"
echo ""

# 检查 npm
if ! command -v npm &> /dev/null; then
    echo "❌ npm 未安装"
    exit 1
fi

echo "✅ npm 版本：$(npm -v)"
echo ""

# 安装依赖
echo "📦 安装项目依赖..."
npm install
echo "✅ 依赖安装完成"
echo ""

# 初始化 Git
echo "🔧 初始化 Git 仓库..."
if [ ! -d ".git" ]; then
    git init
    git add .
    git commit -m "Initial commit - DeRouter clone project"
    echo "✅ Git 仓库初始化完成"
else
    echo "⚠️  Git 仓库已存在"
fi
echo ""

# 显示下一步指引
echo "=================================="
echo "✅ 项目初始化完成！"
echo ""
echo "📋 下一步操作："
echo ""
echo "1️⃣  创建 GitHub 仓库并推送代码"
echo "   git branch -M main"
echo "   git remote add origin <your-github-repo-url>"
echo "   git push -u origin main"
echo ""
echo "2️⃣  注册必要服务"
echo "   - Privy (Provider 平台登录): https://privy.io"
echo "   - Supabase (Consumer 平台后端): https://supabase.com"
echo "   - Cloudflare/Vercel (部署平台)"
echo ""
echo "3️⃣  配置环境变量"
echo "   - apps/provider/.env.local"
echo "   - apps/consumer/.env.local"
echo ""
echo "4️⃣  本地开发测试"
echo "   npm run dev"
echo ""
echo "5️⃣  部署到 Cloudflare Pages 或 Vercel"
echo "   查看 docs/部署指南.md"
echo ""
echo "=================================="
echo "💡 提示：详细文档在 docs/ 目录下"
echo ""
