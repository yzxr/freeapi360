# DeRouter Clone - AI 算力共享网络平台

> 复刻 DeRouter 双平台模式：托管平台 + 采购平台

**GitHub**: https://github.com/yzxr/freeapi360

**域名**：
- API 托管站：https://freeapi.cc.cd
- API 购买站：https://freecode.cc.cd

## 📋 项目结构

```
derouter-clone/
├── apps/
│   ├── provider/          # 托管平台 (derouter.network 复刻)
│   │   ├──  Provider 端：AI 账号托管、收益管理、Solana 结算
│   │   └── 技术栈：Next.js + Privy + Solana
│   │
│   └── consumer/          # 采购平台 (derouter.ai 复刻)
│       ├──  Consumer 端：API 调用、客户密钥、推荐返佣
│       └── 技术栈：Next.js + Supabase
│
├── packages/
│   ├── ui/                # 共享 UI 组件库
│   ├── lib/               # 共享工具库
│   └── contracts/         # Solana 智能合约
│
└── docs/                  # 项目文档
```

## 🚀 快速开始

### 前置要求
- Node.js 18+
- pnpm 或 npm
- Solana 钱包（Phantom）

### 安装依赖
```bash
npm install
```

### 开发模式
```bash
# 同时启动两个平台
npm run dev

# 只启动托管平台
npm run dev:provider

# 只启动采购平台
npm run dev:consumer
```

## 🌐 域名规划

| 平台 | 域名 | 用途 |
|------|------|------|
| **API 托管站** | `freeapi.cc.cd` | Provider 平台 - API 密钥托管、账号管理 |
| **API 购买站** | `freecode.cc.cd` | Consumer 平台 - API 购买、客户密钥、推荐返佣 |

## 📦 技术栈

### API 托管站 (freeapi.cc.cd)
- **前端**：Next.js 14 + Tailwind CSS
- **Web3**：Privy（身份验证）+ Solana Web3
- **部署**：Vercel / Cloudflare Pages

### API 购买站 (freecode.cc.cd)
- **前端**：Next.js 14 + Tailwind CSS
- **后端**：Supabase（Auth + DB + Edge Functions）
- **部署**：Vercel / Cloudflare Pages

### 共享
- **UI 组件**：Shadcn UI
- **智能合约**：Solana Program Library
- **代理网络**：分布式代理（多地区）

## 🎯 核心功能

### 托管平台
- [ ] Privy 邮箱登录 + 自动创建 Solana 钱包
- [ ] 地区选择（5 个代理出口）
- [ ] Claude/Codex 账号连接
- [ ] 收益仪表盘（实时）
- [ ] USDC 自动结算（$10 阈值）

### 采购平台
- [ ] 邮箱验证码登录
- [ ] API 密钥管理
- [ ] 客户密钥系统（预算分配）
- [ ] 推荐返佣（30% 终身）
- [ ] 用量统计与充值

### 路由层
- [ ] 请求智能路由
- [ ] 账号健康监控
- [ ] Token 计量计费
- [ ] 分布式代理网络

## 📄 文档

- [项目方案](./docs/项目方案.md)
- [托管平台分析](./docs/托管平台分析.md)
- [采购平台分析](./docs/后台结构分析.md)

## ⚠️ 风险提示

1. **账号共享合规性**：违反 Claude/OpenAI ToS
2. **账号封禁风险**：需实现风控规避策略
3. **法律风险**：建议咨询法律意见

## 📈 开发进度

| 阶段 | 内容 | 状态 | 预计完成 |
|------|------|------|----------|
| Phase 1 | 项目初始化 + 基础架构 | 🔄 进行中 | Week 1 |
| Phase 2 | Privy 登录 + 钱包集成 | ⏳ 待开始 | Week 2 |
| Phase 3 | AI 账号连接 | ⏳ 待开始 | Week 3-4 |
| Phase 4 | 代理网络 + 路由 | ⏳ 待开始 | Week 5-7 |
| Phase 5 | 计量计费 + 结算 | ⏳ 待开始 | Week 8-10 |
| Phase 6 | 采购端完整功能 | ⏳ 待开始 | Week 11-13 |
| Phase 7 | 测试 + 优化 | ⏳ 待开始 | Week 14-15 |

## 🤝 贡献

内部项目，暂不对外开放。

## 📞 联系

- 项目发起人：刚哥
- 技术负责人：月仙总监
- 启动时间：2026-04-09

---

**商业机密 · 内部资料 · 请勿外传**
