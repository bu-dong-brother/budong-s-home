# 🇧🇷 巴西电子商务运营分析与 RFM 客户分层
> **Permalink**: [巴西电子商务运营分析与 RFM 客户分层](https://github.com/bu-dong-brother/budong-s-home)

**TL;DR**：该项目演示了从 SQL 复杂数据清洗到 Excel 建模，最后通过 Tableau 实现商业智能可视化的完整闭环。基于 Olist 真实数据集，通过 RFM 模型将 10 万+ 用户进行分层，并产出具体的运营策略。

---

## 🙋‍♂️ 一句自我定位
具备全栈数据分析思维的学习者，能够结合 **SQL (数据处理)**、**Excel (业务建模)** 与 **Tableau (可视化决策)**，将海量原始数据转化为可落地的商业增长建议。

## 🛠️ 工具与技能
*   **核心工具**：MySQL, Excel, Tableau
*   **技术栈**：
    *   **SQL**：多表关联 (Joins)、聚合 (Aggregations)、时间函数、数据清洗
    *   **Excel**：RFM 模型计算、PercentRank 函数、数据透视表
    *   **Tableau**：交互式仪表板设计、地理空间分析、参数控制

## 📊 项目概览 (Why / What)
*   **目标**：处理 Olist 平台 10 万+ 条真实订单数据，评估整体运营状况，并利用 RFM 模型识别高价值客户与流失风险。
*   **数据源**：[Olist Brazilian E-Commerce Public Dataset](https://www.kaggle.com/olistbr/brazilian-ecommerce) (Kaggle)
*   **交付物**：SQL 清洗脚本、Excel 模型源文件、Tableau 打包工作簿 (.twbx)、分析报告。

## 💡 项目亮点与商业发现
*   **数据规模**：N = 100k+ 订单，涵盖 9 个关联数据表。
*   **RFM 分层 & 策略建议**：
    *   **🏆 重要价值客户 (Champions/Loyal)**
        *   *特征*：高频购买、最近有交易、高消费。
        *   *策略*：提供 VIP 专属客服通道、新品优先体验权、老带新激励计划。
        *   *目标 KPI*：NPS (净推荐值)、CLV (客户终身价值)。
    *   **📈 潜力发展客户 (Potential Loyalist)**
        *   *特���*：购买频率中等，但消费金额尚可。
        *   *策略*：基于购买历史的精准推荐 (Cross-sell)、满减优惠券刺激复购。
        *   *目标 KPI*：复购率、客单价 (AOV) 提升。
    *   **💤 挽留/流失客户 (At Risk/Lost)**
        *   *特征*：很久未消费，或仅消费一次且金额低。
        *   *策略*：发送“我们想念你”召回邮件（包含低门槛折扣）、调研流失原因。
        *   *目标 KPI*：召回率 (Reactivation Rate)、营销ROI。

## 💻 技术实现细节
1.  **MySQL 数据清洗**：
    *   剔除 `order_status` 非 `delivered` 的异常订单。
    *   标准化时间戳格式，计算 `Recency` (最近一次购买距今天数)。
    *   通过 `INNER JOIN` 关联 Customers, Orders, Payments, Items 四张核心表。
2.  **Excel RFM 建模**：
    *   使用 `PERCENTRANK.EXC` 对 R/F/M 值进行 1-5 分打分。
    *   拼接 `R_Score` + `F_Score` + `M_Score` 生成用户标签（如 "555" 为最高价值）。
3.  **Tableau 可视化**：
    *   **销售看板**：追踪 GMV 月度趋势与季节性波动。
    *   **地理分布**：可视化巴西各州（如 SP, RJ）的订单密度与物流时效。
    *   **RFM 矩阵**：动态展示不同价值层级的用户占比与营收贡献。

## 🚀 如何复现 (快速开始)

1.  **获取代码**
    ```bash
    git clone https://github.com/bu-dong-brother/budong-s-home.git
    cd budong-s-home/巴西电子商务分析
    ```

2.  **准备数据**
    *   访问 Kaggle 下载 Olist 数据集 (CSV格式)。
    *   将 CSV 文件导入本地 MySQL 数据库 (建议使用 Navicat 或 Workbench 导入向导)。

3.  **运行流程**
    *   **Step 1 (SQL)**: 在数据库中运行 `sql/data_cleaning.sql`，生成清洗后的宽表。
    *   **Step 2 (Excel)**: 打开 `excel/rfm_model_template.xlsx`，填入导出的数据进行评分计算。
    *   **Step 3 (Tableau)**: 使用 Tableau Desktop / Reader 打开 `dashboard/ecommerce_analysis.twbx` 查看可视化结果。
