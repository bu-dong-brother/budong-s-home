# 电子商务订单数据分析（RFM 示例）

TL;DR：该项目演示了从 Excel 原始数据到可复现分析流程（Jupyter Notebook）、数据清洗、RFM 客群分层与可视化的完整过程，适合作为数据分析实习/作品展示。

一句自我定位
- 具备扎实的数据清洗与分析能力，熟练使用 Excel、Python（pandas、matplotlib）及 Jupyter Notebook，将复杂数据转化为可执行的商业建议。

工具与技能
- 常用：Excel, Python, pandas, matplotlib, Jupyter Notebook
- 其他：seaborn / altair（基础），正在通过小项目进一步学习

项目概览（Why / What）
- 目标：清洗订单数据并基于 RFM（Recency, Frequency, Monetary）方法对客户进行分层，产出可执行营销策略建议。
- 交付物：Jupyter Notebook（核心分析流程）、关键图表、README.md、DATA_LICENSE.md

项目亮点
- 数据规模：N = 9,800 条订单
- RFM 分层 & 示例结论：
  - 重点客户（9.8%）
    - 策略：VIP 关怀、专属折扣与优先体验、客服主动触达、邀请高毛利/付费活动
    - 目标 KPI：留存率、复购率、单客 LTV 提升
  - 潜力客户（47.2%）
    - 策略：精准促销（cross-sell / up-sell）、频次驱动活动、价值教育
    - 目标 KPI：转化率（潜力→重点）、客单价（AOV）、复购频次
  - 普通客户（39.1%）
    - 策略：定期触达、会员积分、节假日活动
    - 目标 KPI：活跃率、复购周期缩短
  - 低价值 / 流失（3.9%）
    - 策略：分层再激活（阶梯式触达）、降低长期不响应者的触达成本
    - 目标 KPI：再激活率、CAC 与回收比率

技术要点
- 可复现的数据清洗脚本（Jupyter Notebook）
- RFM 分层逻辑与可视化（聚类/分箱或自定义规则）
- 分析结论直接映射到商业策略与 KPI 建议

如何复现（快速开始）
1. 克隆仓库并进入目录
   git clone https://github.com/bu-dong-brother/budong-s-home
   cd budong-s-home
2. 建议创建虚拟环境并安装依赖
   python -m venv .venv
   source .venv/bin/activate   # macOS / Linux
   .venv\Scripts\activate      # Windows
   pip install -r requirements.txt
3. 获取数据（见 DATA_LICENSE.md）
   - 推荐：使用 Kaggle CLI 从原始数据源下载并放到 `data/` 目录
   - 或：如果仓库 release/提供数据包，可直接下载并解压到 `data/`
4. 运行 Notebook
   jupyter lab
   打开并按单元顺序运行 `notebooks/` 中的主 Notebook（建议先用 sample 数据或 subset 运行一遍）

目录建议（仓库结构示例）
- notebooks/  -> Jupyter Notebook（主分析）
- outputs/    -> 生成的图表、报告（可纳入 release）

许可与数据合规
- 代码：建议采用 GPL-2 许可证（LICENSE 文件）
- 数据：请查看 `DATA_LICENSE.md`，说明数据来源与许可（若数据含敏感信息请勿上传）

发布前检查（建议）
- 移除/隐藏任何 API key、凭证或绝对路径
- 确保 Notebook 中没有暴露个人隐私数据
- 如需公开原始数据，确认 Kaggle/数据作者允许再分发并在 `DATA_LICENSE.md` 中注明来源与版权

联系方式
- Email: 3579136938@qq.com
- GitHub: https://github.com/bu-dong-brother/budong-s-home

贡献
- 欢迎 issue/PR。请在 PR 描述中说明改动并确保文档和依赖更新到位。
