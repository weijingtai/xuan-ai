# AI 占测系统 - 产品需求文档 (PRD)

## 1. 产品概述

### 1.1 产品愿景
在玄学占测应用中集成 AI 大语言模型能力，为用户提供智能化的占测解读、教学辅助和多技法协作能力。

### 1.2 目标用户
- **初学者**: 需要 AI 解释占测结果和玄学概念
- **进阶用户**: 需要 AI 辅助分析复杂盘局
- **专业用户**: 需要多 Agent 协作进行综合研判

### 1.3 核心价值
- 降低玄学学习门槛
- 提供可信赖的解读溯源
- 支持跨技法综合分析

## 2. 功能需求

### 2.1 AI 对话系统
- 支持流式响应显示
- 对话历史持久化
- 会话可恢复
- AI 可通过 Function Calling 访问式盘数据

### 2.2 AI 人设系统
- 拟人化配置（名称、头像、性格）
- 专业领域设置
- 温度等参数调节

### 2.3 Prompt 管理
- 模板创建/编辑
- 版本历史（不可变）
- 变量替换
- 技法绑定

### 2.4 工具系统
- DivinationSkillInterface 接口
- ToolRegistry 工具注册
- 中间件支持（日志、验证、限流）

### 2.5 溯源系统
- API 调用记录
- 工具调用记录
- 上下文快照
- 完整性校验

### 2.6 Multi-Agent 系统
- 跨技法调用
- 共享上下文传递
- 调用链追踪
- 深度限制和超时处理

### 2.7 审计系统
- Token 消耗统计
- 调用频率记录
- 费用估算

## 3. 数据模型

### 核心实体
- LlmProvider / LlmModel
- PromptTemplate / PromptVersion
- AiPersona
- AiChatSession / AiChatMessage
- AiProvenance
- AgentInvocation
- AiUsageAudit

## 4. 接口设计

### 对外暴露
- `AiChatWindow`: 对话窗口 Widget
- `DivinationSkillInterface`: 技法接口
- `AiDatabase`: 数据库访问

### 服务接口
- `LlmService`: LLM 调用
- `ChatService`: 对话管理
- `PromptService`: Prompt 管理
- `ProvenanceService`: 溯源服务
- `AgentOrchestrator`: Agent 编排

## 5. 验收标准

1. 配置自定义 API 端点成功
2. 起局后可打开 AI 对话
3. 流式响应正常显示
4. 对话历史正确保存
5. 溯源记录完整可查
6. Agent 调用链可追踪
