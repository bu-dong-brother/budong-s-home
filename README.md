# budong-s-home
这是 W1 的最小演示仓库：一个本地可运行的 Streamlit 小站，用来展示 KPI、简单漏斗与次日留存。  
下面包含快速运行方式、演示截图占位，以及你可以在合并 PR 前直接粘贴/上传的说明。
演示（线上/本地）
- 线上（可选，部署后填）：https://share.streamlit.io/你的用户名/budong-s-home/main/app.py
- 本地运行（推荐演示给面试官或内推人）：  
1. 克隆仓库     
git clone https://github.com/bu-dong-brother/budong-s-home.git     
cd budong-s-home  
2. 新建并激活虚拟环境     
python -m venv .venv     
Windows: .venv\Scripts\activate     
Mac/Linux: source .venv/bin/activate  
3. 安装依赖     
pip install -r requirements.txt  
4. 启动演示     
streamlit run app.py  
5. 打开浏览器访问 http://localhost:8501，截图或录屏并保存
W1 — 本地演示截图（请把截图文件上传到 docs/screenshots/ 并改名为下列路径）
下面占位图片为示例，上传后会自动显示真实图片。
![KPI screenshot](./docs/screenshots/w1_kpi.png)
![Funnel/Retention screenshot](./docs/screenshots/w1_funnel_retention.png)
你可以在仓库网页上：点击 “添加文件” → “上传文件”，把截图上传到 `docs/screenshots/`，然后在 README 的这一段保留图片链接即可。
运行与验证说明（给面试官看的短说明）
- 本地运行后，主页会展示三个 KPI（用户数 / 订单数 / GMV），并提供一个简单的漏斗图与 D1 留存线图。  
- 若你需要我远程演示，我可提供 2 分钟录屏或线上部署链接。
本次提交内容（W1）
- app.py：Streamlit 演示（KPI / 漏斗 / 留存）
- requirements.txt：最小依赖
- data/sample_orders.csv：示例数据
- docs/metrics.md：指标口径说明（简版）
- docs/weekly-2025-W1.md：W1 周报模板（请补充你的姓名与截图路径）
建议的提交信息（Commit messages）
- feat: add Streamlit demo (W1)
- docs: add W1 demo screenshots
- docs: add W1 weekly report
下一步（W2）
- 生成并替换为 2000 行模拟数据（data/sim_orders_2000.csv），并补全 `docs/metrics.md` 的详细口径说明。
