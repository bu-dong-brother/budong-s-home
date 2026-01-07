# 北京租房数据分析（学习示例 — 链家爬取样本）

说明
- 本仓库为教学/学习用途，展示从链家公开房源页面抓取样本到数据清洗与可视化的全过程（含 Jupyter Notebook 与若干静态图）。**不用于任何商业目的**。
- 本仓库提供已脱敏的样本数据。原始抓取脚本仅供学习参考，请在符合法律/网站条款的前提下使用。

内容
- notebooks/
  - 半自动化爬虫 notebook（已去除浏览器会话/凭据）
  - 数据清洗 notebook（标准化价格、面积、每平米价）
- data/
  - sample_lianjia.csv（脱敏样本，聚合/示例）
- images/
  - 仪表盘截图与分析图（png）
- requirements.txt：运行 notebook 所需的 Python 包

免责声明与法律说明
- 数据来源：链家网站公开页面（抓取时间：2026-01-04）。为保护隐私，已从公开内容中移除或脱敏原始 URL / 联系方式等。请勿将本仓库中的数据用于商业用途或线下交易。
- 声明：本仓库仅用于学习与研究，若权利方提出异议我将配合删除相关数据/内容。
- License:
  - 代码：MIT License（或你选择的其他开源许可）
  - 数据样本：CC BY-NC-SA 4.0（建议：署名-非商业-相同方式共享）

如何运行（快速指南）
1. 克隆仓库：
   git clone [https://github.com/<your-username>/<repo>.githttps://github.com/bu-dong-brother/budong-s-home](https://github.com/bu-dong-brother/budong-s-home)
2. 创建虚拟环境并安装依赖：
   python -m venv venv
   source venv/bin/activate  # Linux/macOS
   venv\Scripts\activate     # Windows
   pip install -r requirements.txt
3. 清理 notebook（若需要）：
   jupyter nbconvert --clear-output --inplace notebooks/*.ipynb
4. 在 Jupyter Lab / Notebook 中打开并运行。

如何复现爬虫（警告）
- 抓取脚本仅供教学：在运行真实爬虫前请确认目标网站的 robots.txt 和服务条款；不要抓取或公开个人敏感信息；避免高频访问导致封禁或违反条款。

联系
- 如需删除或修改数据，请联系：3579136938@qq.com
