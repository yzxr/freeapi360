# API 托管站

**域名**：https://freeapi.cc.cd
**定位**：Provider 端 - AI 账号托管与收益管理平台

---

## 🎯 核心功能

### 1. 账号托管
- 连接 Claude Pro 账号
- 连接 Codex/OpenAI 账号
- 账号健康监控
- 代理地区选择（5 个地区）

### 2. 收益管理
- 实时收益统计
- 请求量监控
- Token 用量追踪
- Top Provider 排行榜

### 3. 钱包与结算
- Privy 自动创建 Solana 钱包
- USDC 自动结算（$10 阈值）
- 交易记录查询
- 提现管理

### 4. 网络监控
- 在线 Provider 数量
- 24h 请求量统计
- 网络负载与定价
- 节点地区分布

---

## 🏗️ 技术架构

```
┌─────────────────────────────────────┐
│         前端 (Next.js 14)           │
│  - Tailwind CSS                     │
│  - Privy (Web3 登录)                │
│  - Solana Web3.js                   │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│      后端 (Supabase Edge Fns)       │
│  - 账号管理 API                     │
│  - 收益计算                         │
│  - 请求路由                         │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│     代理网络 (5 地区分布式)          │
│  - Singapore (39 节点)              │
│  - Los Angeles (1 节点)             │
│  - London (1 节点)                  │
│  - Sydney (1 节点)                  │
│  - Toronto (1 节点)                 │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│   AI 平台 (Claude/OpenAI API)       │
│  - 账号池管理                       │
│  - 请求转发                         │
│  - 限流控制                         │
└─────────────────────────────────────┘
```

---

## 📁 目录结构

```
apps/provider/
├── app/
│   ├── page.tsx              # 首页（仪表盘）
│   ├── login/                # 登录页
│   ├── earnings/             # 收益页
│   ├── connect/              # 连接 AI 账号
│   ├── wallet/               # 钱包设置
│   └── api-usage/            # 用量统计
├── components/
│   ├── Navbar.tsx
│   ├── Dashboard.tsx
│   ├── EarningsChart.tsx
│   ├── ProviderList.tsx
│   └── RegionSelector.tsx
├── lib/
│   ├── privy.ts              # Privy 配置
│   ├── solana.ts             # Solana 集成
│   └── api.ts                # API 调用
└── hooks/
    ├── usePrivy.ts
    └── useEarnings.ts
```

---

## 🔐 登录流程

```
1. 用户访问 freeapi.cc.cd
2. 点击"登录"
3. 输入邮箱
4. Privy 发送验证码
5. 输入 6 位验证码
6. 自动创建 Solana 钱包
7. 登录成功，跳转到仪表盘
```

**钱包地址示例**：
```
BFnvHHqdYGWcu3B9f5wz2GfNBzewidUmMPApCc91Ymeq
```

---

## 💰 收益计算

### Claude 模型（Provider 获得 75%）

| 模型 | 输入价格 | 输出价格 | Provider 收益 |
|------|----------|----------|---------------|
| Claude Opus 4.6 | $1.00/M | $5.00/M | $0.75/$3.75 |
| Claude Sonnet 4.6 | $0.60/M | $3.00/M | $0.45/$2.25 |
| Claude Haiku 4.5 | $0.20/M | $1.00/M | $0.15/$0.75 |

### OpenAI 模型（Provider 获得 89%）

| 模型 | 输入价格 | 输出价格 | Provider 收益 |
|------|----------|----------|---------------|
| GPT-5.4 | $0.20/M | $0.80/M | $0.18/$0.71 |
| GPT-5.3 Codex | $0.14/M | $1.12/M | $0.12/$0.99 |

---

## 🌍 地区选择

用户连接 AI 账号时需选择代理出口地区：

| 地区 | 节点数 | 推荐度 |
|------|--------|--------|
| Singapore | 39 | ⭐⭐⭐⭐⭐ |
| Los Angeles | 1 | ⭐⭐⭐ |
| London | 1 | ⭐⭐⭐ |
| Sydney | 1 | ⭐⭐⭐ |
| Toronto | 1 | ⭐⭐⭐ |

**作用**：
- 分散 IP 风险
- 避免单点风控
- 提高请求成功率

---

## 📊 核心 API

### Provider 端 API

```typescript
// 获取 Provider 状态
GET /api/provider/status

// 连接 AI 账号
POST /api/provider/connect
Body: {
  platform: "claude" | "codex",
  region: "sg" | "la" | "lon" | "syd" | "tor",
  credentials: { ... }
}

// 断开 AI 账号
POST /api/provider/disconnect
Body: { accountId: string }

// 获取收益统计
GET /api/provider/earnings?days=7

// 获取请求日志
GET /api/provider/requests?limit=50

// 获取钱包信息
GET /api/provider/wallet
```

### 链上结算

```rust
// Solana Program (Rust)
// USDC 自动打款
pub fn process_settle(ctx: Context<Settle>, amount: u64) -> Result<()> {
    // 验证收益达到$10
    // 转账 USDC 到 Provider 钱包
    // 记录交易
}
```

---

## 🎨 UI 设计要点

### 首页仪表盘
- 收益概览（今日/本周/本月）
- 在线账号状态
- 实时请求量图表
- Top Provider 排行榜

### 连接 AI 账号
- 平台选择（Claude/Codex）
- 地区选择（5 个按钮）
- 授权流程引导
- 账号状态验证

### 收益页面
- 收益趋势图（7 天/30 天）
- 明细列表（按模型/日期）
- 提现记录
- 钱包地址显示

---

## ⚠️ 风控策略

### 账号保护
- 请求速率限制（RPM）
- 并发数控制
- 异常检测（自动下线）
- 地区分散

### 平台保护
- 最低提现门槛（$10）
- 提现审核（大额）
- 异常收益调查
- ToS 合规审查

---

## 📈 开发进度

| 阶段 | 内容 | 状态 | 预计完成 |
|------|------|------|----------|
| Phase 1 | 项目初始化 | ✅ 完成 | 2026-04-09 |
| Phase 2 | Privy 登录集成 | ⏳ 进行中 | Week 2 |
| Phase 3 | AI 账号连接 | ⏳ 待开始 | Week 3-4 |
| Phase 4 | 收益系统 | ⏳ 待开始 | Week 5-6 |
| Phase 5 | Solana 结算 | ⏳ 待开始 | Week 7-8 |
| Phase 6 | 测试优化 | ⏳ 待开始 | Week 9-10 |

---

## 🔗 相关文档

- [项目方案](./项目方案.md)
- [托管平台分析](./托管平台分析.md)
- [域名配置](./域名配置.md)
- [部署指南](./部署指南.md)

---

**文档创建时间**：2026-04-09
**创建者**：月仙总监
**状态**：开发中 🚧
