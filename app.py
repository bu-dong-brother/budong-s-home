
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
app.py - Streamlit demo for RFM customer segmentation
Copyright (c) 2025 bu-dong-brother
License: See LICENSE (GPL-2)
Data license: See DATA_LICENSE.md
"""

import streamlit as st
import pandas as pd
import altair as alt
from src.rfm import compute_rfm, rfm_score

st.set_page_config(page_title="RFM 分析 Demo", layout="wide")

st.title("RFM 客群分层 Demo")
st.markdown("上传 CSV 或在本地 `data/` 下放置文件。应用会尝试自动识别列名：日期、客户ID、金额。")

# Sidebar: data input
st.sidebar.header("数据输入")
uploaded_file = st.sidebar.file_uploader("上传 CSV 文件", type=['csv'])
use_sample = st.sidebar.checkbox("Use sample data file from data/sample_sales.csv if present", value=True)
reference_date_input = st.sidebar.date_input("参考日期 (默认为数据的 max date + 1 day)", value=None)

df = None
if uploaded_file is not None:
    try:
        df = pd.read_csv(uploaded_file)
        st.sidebar.success("已加载上传的文件")
    except Exception as e:
        st.sidebar.error(f"读取上传文件失败: {e}")

if df is None and use_sample:
    try:
        df = pd.read_csv("data/sample_sales.csv")
        st.sidebar.info("已加载 data/sample_sales.csv 示例数据")
    except Exception:
        df = None

if df is None:
    st.warning("当前没有可用数据。请上传 CSV，或在仓库的 data/ 放置 sample_sales.csv 并勾选使用示例。")
    st.stop()

st.subheader("数据预览")
st.dataframe(df.head(10))

# 侧边栏自动识别与手动选择列
st.sidebar.subheader("列选择（自动识别或手动选择）")
cols = list(df.columns)
customer_col = st.sidebar.selectbox("选择客户列", options=[None] + cols, index=0)
date_col = st.sidebar.selectbox("选择日期列", options=[None] + cols, index=0)
amount_col = st.sidebar.selectbox("选择金额列", options=[None] + cols, index=0)

if customer_col is None or date_col is None or amount_col is None:
    st.error("请在侧边栏选择客户列、日期列和金额列后继续。")
    st.stop()

ref_date = None
if reference_date_input is not None:
    try:
        ref_date = pd.to_datetime(reference_date_input)
    except Exception:
        ref_date = None

with st.spinner("计算 RFM 指标..."):
    rfm = compute_rfm(df, customer_col, date_col, amount_col, reference_date=ref_date)
    rfm = rfm_score(rfm)

st.subheader("RFM 指标（按客户）")
st.dataframe(rfm.head(30))

seg_counts = rfm['segment'].value_counts().reset_index().rename(columns={'index': 'segment', 'segment': 'count'})
st.subheader("分层分布")
st.table(seg_counts)

# 简单可视化
st.subheader("分层可视化")
bar = alt.Chart(seg_counts).mark_bar().encode(
    x=alt.X('segment:N', sort='-y', title='Segment'),
    y=alt.Y('count:Q', title='Count'),
    color='segment:N'
).properties(width=700, height=300)
st.altair_chart(bar, use_container_width=True)

st.subheader("导出结果")
csv_bytes = rfm.to_csv(index=False).encode('utf-8')
st.download_button("下载 RFM CSV", data=csv_bytes, file_name="rfm_result.csv", mime="text/csv")

st.success("完成。请根据业务调整分层阈值。")
