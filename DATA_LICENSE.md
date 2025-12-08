# 数据来源与许可说明
已确定的数据来源
- 数据集名：Sales Forecasting (by rohitsahoo)
- Kaggle 页面：https://www.kaggle.com/datasets/rohitsahoo/sales-forecasting
- 建议在仓库中放置数据的位置：`data/`
- 数据量示例：原始数据集为商品销售记录
重要合规与发布注意事项（请在发布前务必核实）
1. 核验许可   
- 请以 Kaggle 数据集页面上显示的许可/使用条款为准。若页面标注为 GPL-2，请在仓库根目录保留 LICENSE（包含 GPL-2 全文），并在仓库中明确标注数据来源与版权信息。   
- 若 Kaggle 页面或数据作者在描述中有额外的署名/引用要求，请按其要求补充到本仓库的 README 或 DATA_LICENSE.md 中。
2. 隐私与敏感信息   
- 检查数据是否包含任何可直接识别的个人信息（姓名、手机号、身份证号、电子邮件等）。若包含敏感数据，请在公开前进行脱敏或仅提供下载说明而不将原始数据推送到公共仓库。
3. 推荐的稳妥做法
- 默认不要直接把原始数据上传到 GitHub 公共仓库。   
- 更推荐的方式：     
- 在仓库内提供下载说明或脚本，引导使用者从 Kaggle 下载原始数据并放到本地的 `data/` 目录；或     
- 将已许可的数据发布到 GitHub Releases、Zenodo、或其它云端存储，并在 README/DATA_LICENSE.md 中提供下载链接与许可说明。   
- 如果决定将数据提交到仓库，请使用 Git LFS 跟踪大文件以避免常规 git push 失败。
4. Kaggle CLI 下载示例
- 安装 kaggle CLI（见 https://github.com/Kaggle/kaggle-api）     
pip install kaggle   
- 将你的 Kaggle API token 放到 `~/.kaggle/kaggle.json`（注意权限设置）   
- 创建 data 目录并下载解压：     
mkdir -p data     
kaggle datasets download -d rohitsahoo/sales-forecasting -p data/     
unzip -o data/sales-forecasting.zip -d data/   
- 下载完成后，请检查解压出的文件并根据 Notebook 的预期路径放置数据。
5. 不要忘记在仓库中记录来源与引用   
- 建议在 README.md、Notebook 顶部的说明 cell，以及本文件中保留以下引用句：     
"Dataset: Sales Forecasting by rohitsahoo. Source: https://www.kaggle.com/datasets/rohitsahoo/sales-forecasting"   
- 若 Kaggle 页面提供推荐的引用格式或 DOI，请按其要求引用或署名。
6. 发布前核对清单（简要）   
- 在最终发布前，回到 Kaggle 页面再次核验数据许可与作者说明。   
- 确认数据不包含需保护的个人隐私信息，或已完成必要的脱敏。   
- 若许可为 GPL-2，确保仓库中包含 GPL-2 的 LICENSE 文件，并在 README/DATA_LICENSE.md 中明确声明数据许可与归属。
示例 Attribution
- 数据来源：Sales Forecasting by rohitsahoo — https://www.kaggle.com/datasets/rohitsahoo/sales-forecasting
- 许可：以 Kaggle 页面上所示许可为准（如页面标注 GPL-2，请在仓库中保留 GPL-2 LICENSE）
