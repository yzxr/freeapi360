# API 购买站

**域名**：https://freecode.cc.cd
**定位**：Consumer 端 - API 购买与客户密钥管理平台

---

## 🎯 核心功能

### 1. API 密钥管理
- 个人账户密钥创建
- 密钥启用/禁用
- 密钥用量统计
- 密钥删除

### 2. 客户密钥系统
- 创建下游客户密钥
- 预算分配（USD）
- 速率限制配置
- 用量追踪与审计

### 3. 推荐返佣
- 推荐码生成（8 位默认）
- 自定义推荐码（品牌化）
- 返佣统计（30% 终身）
- 推荐用户管理

### 4. 充值支付
- 加密货币充值
- 微信支付
- 余额管理
- 交易记录

### 5. 用量统计
- 实时请求日志
- Token 消耗统计
- 模型用量分布
- 费用分析

---

## 🏗️ 技术架构

```
┌─────────────────────────────────────┐
│         前端 (Next.js 14)           │
│  - Tailwind CSS                     │
│  - Supabase Auth                    │
│  - Charts (Recharts)                │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│    后端 (Supabase + Edge Fns)       │
│  - 邮箱验证码登录                   │
│  - API 密钥管理                     │
│  - 客户密钥系统                     │
│  - 推荐返佣计算                     │
│  - 用量统计                         │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│      数据库 (Supabase PG)           │
│  - users                            │
│  - api_keys                         │
│  - sub_keys                         │
│  - referrals                        │
│  - usage_logs                       │
│  - transactions                     │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│    上游 API (freeapi.cc.cd)         │
│  - 请求转发                         │
│  - Token 计量                       │
│  - 实时计费                         │
└─────────────────────────────────────┘
```

---

## 📁 目录结构

```
apps/consumer/
├── app/
│   ├── page.tsx              # 首页（仪表盘）
│   ├── login/                # 登录页（邮箱验证码）
│   ├── api/                  # API 密钥管理
│   ├── keys/                 # 客户密钥管理
│   ├── referral/             # 推荐返佣
│   ├── usage/                # 用量统计
│   └── topup/                # 充值页面
├── components/
│   ├── Navbar.tsx
│   ├── ApiKeyForm.tsx
│   ├── SubKeyList.tsx
│   ├── ReferralCard.tsx
│   ├── UsageChart.tsx
│   └── TopupForm.tsx
├── lib/
│   ├── supabase.ts           # Supabase 配置
│   ├── api.ts                # API 调用
│   └── utils.ts              # 工具函数
└── hooks/
    ├── useApiKey.ts
    ├── useSubKey.ts
    └── useReferral.ts
```

---

## 🔐 登录流程

```
1. 用户访问 freecode.cc.cd
2. 点击"登录"
3. 输入邮箱
4. 系统发送验证码（邮件/SMS）
5. 输入 6 位验证码
6. 登录成功
```

**无密码设计**：降低注册门槛，提升转化率

---

## 🔑 API 密钥系统

### 账户密钥（主密钥）

```json
{
  "id": "uuid",
  "userId": "user_uuid",
  "key": "sk-ant-xxx...",
  "keyId": "sk-ant-xxx",
  "label": "My Main Key",
  "createdAt": "2026-04-09T00:00:00Z",
  "status": "active"
}
```

**权限**：
- 创建/删除客户密钥
- 查看全账户用量
- 管理余额
- 调用所有 API

### 客户密钥（Sub-Key）

```json
{
  "id": "uuid",
  "accountId": "account_uuid",
  "key": "sk-ant-yyy...",
  "keyId": "sk-ant-yyy",
  "label": "客户 A",
  "budgetVirtual": 50.00,
  "spentVirtual": 12.50,
  "remainingVirtual": 37.50,
  "rpmLimit": 60,
  "concurrentLimit": 5,
  "createdAt": "2026-04-09T00:00:00Z"
}
```

**权限**：
- 自助查询余额
- 自助查询用量
- 调用 AI API
- **不可**创建下级密钥

---

## 💰 推荐返佣系统

### 返佣规则

| 项目 | 说明 |
|------|------|
| **返佣比例** | 30%（平台利润的 30%） |
| **结算方式** | 自动到账，无门槛 |
| **时效** | 终身有效 |
| **绑定** | 一次性绑定，不可更改 |

### 推荐码格式

- **默认**：8 位随机字母数字（如 `F82A61ED`）
- **自定义**：3-20 位字母数字（允许连字符）
- **格式**：`https://freecode.cc.cd?ref=MY-BRAND`

### 返佣计算

```typescript
// 返佣计算公式
function calculateCommission(apiCost: number): number {
  const platformMargin = apiCost * 0.25; // 平台毛利 25%
  const commission = platformMargin * 0.30; // 返佣 30%
  return commission;
}

// 示例：$100 的 API 调用
// 平台毛利 = $100 * 25% = $25
// 返佣 = $25 * 30% = $7.50
```

---

## 📊 核心 API

### Consumer 端 API

```typescript
// 获取余额
POST /api/balance
Headers: { Authorization: "Bearer sk-ant-xxx" }
Response: {
  "balance": "100.0000",
  "locked_balance": "20.0000",
  "available": "80.0000"
}

// 列出客户密钥
POST /api/list-sub-keys
Response: {
  "subKeys": [
    {
      "id": "uuid",
      "label": "客户 A",
      "keyId": "sk-ant-abc...",
      "budgetVirtual": 50,
      "spentVirtual": 12.5,
      "remainingVirtual": 37.5
    }
  ]
}

// 创建客户密钥
POST /api/create-sub-key
Body: {
  "budgetVirtual": 25,
  "label": "客户 B",
  "rpmLimit": 30
}

// 更新客户密钥
POST /api/update-sub-key
Body: {
  "subKeyId": "uuid",
  "addBudgetVirtual": 10,
  "label": "客户 B Pro"
}

// 删除客户密钥
POST /api/delete-sub-key
Body: { "subKeyId": "uuid" }

// 用量日志
POST /api/usage-logs
Body: { "page": 1, "limit": 20, "subKeyId": "uuid" }

// 客户密钥自助查询余额
GET /api/sub-key-balance
Headers: { Authorization: "Bearer sk-ant-yyy" }

// 客户密钥自助查询用量
GET /api/sub-key-usage-logs?page=1&limit=20
```

---

## 💳 充值方式

### 1. 加密货币
- USDC (Solana)
- USDT (TRON/ERC20)
- ETH
- BTC

### 2. 法币支付
- 微信支付
- 支付宝（可选）
- 信用卡（Stripe）

### 3. 充值流程

```
1. 选择充值金额
2. 选择支付方式
3. 生成支付二维码/链接
4. 用户支付
5. 系统确认（自动/手动）
6. 余额到账
```

---

## 📈 用量统计

### 实时日志

```json
{
  "request_id": "req_abc123",
  "model": "claude-sonnet-4-6-20250514",
  "input_tokens": 1500,
  "output_tokens": 800,
  "cache_read_tokens": 0,
  "cache_write_tokens": 0,
  "cost_usdc": 0.0023,
  "duration_ms": 2100,
  "created_at": "2026-04-09T12:00:00Z"
}
```

### 统计维度

- **时间**：今天/本周/本月/累计
- **模型**：Claude Opus/Sonnet/Haiku, GPT-5.4/Codex
- **客户密钥**：按 sub-key 筛选
- **用量类型**：输入 Token/输出 Token/缓存

---

## 🎨 UI 设计要点

### 首页仪表盘
- 余额显示（可用/锁定）
- 今日用量概览
- 快速创建密钥入口
- 推荐返佣卡片

### API 密钥管理
- 密钥列表（脱敏显示）
- 创建/删除按钮
- 用量快捷查看
- 复制密钥功能

### 客户密钥管理
- 预算进度条
- 速率限制显示
- 追加预算按钮
- 用量趋势图

### 推荐返佣
- 推荐码显示 + 复制
- 推荐链接生成
- 累计返佣统计
- 推荐用户列表

---

## 📊 数据库设计

### users 表

```sql
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email TEXT UNIQUE NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  balance_usd DECIMAL(10,4) DEFAULT 0,
  referral_code TEXT UNIQUE,
  referred_by UUID REFERENCES users(id)
);
```

### api_keys 表

```sql
CREATE TABLE api_keys (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id),
  key_id TEXT UNIQUE NOT NULL,
  key_hash TEXT NOT NULL,
  label TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  status TEXT DEFAULT 'active'
);
```

### sub_keys 表

```sql
CREATE TABLE sub_keys (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  account_id UUID REFERENCES api_keys(id),
  key_id TEXT UNIQUE NOT NULL,
  key_hash TEXT NOT NULL,
  label TEXT,
  budget_virtual DECIMAL(10,4) NOT NULL,
  spent_virtual DECIMAL(10,4) DEFAULT 0,
  rpm_limit INT DEFAULT 60,
  concurrent_limit INT DEFAULT 5,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
```

### usage_logs 表

```sql
CREATE TABLE usage_logs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  request_id TEXT UNIQUE NOT NULL,
  sub_key_id UUID REFERENCES sub_keys(id),
  model TEXT NOT NULL,
  input_tokens INT,
  output_tokens INT,
  cost_usdc DECIMAL(10,6),
  created_at TIMESTAMPTZ DEFAULT NOW()
);
```

---

## ⚠️ 安全策略

### API 密钥安全
- 密钥哈希存储（不可逆）
- 传输加密（HTTPS）
- 密钥脱敏显示（`sk-ant-abc...xyz`）
- 删除后不可恢复

### 速率限制
- 账户密钥：默认 100 RPM
- 客户密钥：可配置（默认 60 RPM）
- 并发限制：默认 5

### 预算控制
- 虚拟预算（从主余额扣除）
- 超额自动停止
- 删除密钥预算退回

---

## 📈 开发进度

| 阶段 | 内容 | 状态 | 预计完成 |
|------|------|------|----------|
| Phase 1 | 项目初始化 | ✅ 完成 | 2026-04-09 |
| Phase 2 | Supabase 配置 | ⏳ 进行中 | Week 2 |
| Phase 3 | 邮箱验证码登录 | ⏳ 待开始 | Week 3 |
| Phase 4 | API 密钥系统 | ⏳ 待开始 | Week 4-5 |
| Phase 5 | 客户密钥系统 | ⏳ 待开始 | Week 6-7 |
| Phase 6 | 推荐返佣 | ⏳ 待开始 | Week 8 |
| Phase 7 | 充值支付 | ⏳ 待开始 | Week 9-10 |
| Phase 8 | 测试优化 | ⏳ 待开始 | Week 11-12 |

---

## 🔗 相关文档

- [项目方案](./项目方案.md)
- [后台结构分析](./后台结构分析.md)
- [域名配置](./域名配置.md)
- [部署指南](./部署指南.md)

---

**文档创建时间**：2026-04-09
**创建者**：月仙总监
**状态**：开发中 🚧
