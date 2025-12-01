import streamlit as st
import pandas as pd
st.set_page_config(page_title="简易数据分析站", layout="wide")
st.title("简易数据分析站 - W1 Demo")
@st.cache_data
def load_data():
    df = pd.read_csv("data/sample_orders.csv", parse_dates=["event_time","pay_time"], keep_default_na=False)    
return df
df = load_data()
# KPI
col1, col2, col3 = st.columns(3)
col1.metric("用户数", df["user_id"].nunique())
col2.metric("订单数", int((df['event_type'] == 'pay').sum()))
col3.metric("GMV(¥)", f"{df.loc[df['event_type']=='pay','amount'].sum():.2f}")
st.markdown("---")
st.header("简单漏斗示例")
steps = ["visit", "cart", "pay"]
counts = [int((df['event_type'] == s).sum()) for s in steps]
st.bar_chart(pd.DataFrame({"count": counts}, index=steps))
st.markdown("---")
st.header("简单次日留存（示例）")
df['date'] = pd.to_datetime(df['event_time']).dt.date
first = df.sort_values('event_time').groupby('user_id')['date'].first().rename('d0')
joined = df.join(first, on='user_id')
joined['is_next_day'] = (joined['date'] - joined['d0']).apply(lambda x: x.days == 1)
retention = joined.groupby('d0')['is_next_day'].mean().dropna()
if not retention.empty:
    st.line_chart(retention.rename("D1留存率"))
else:
    st.write("示例数据太少，无法计算留存，请用更多数据测试。")
st.markdown("---")
st.caption("把 sample_orders.csv 替换为真实或更大数据，即可看到效果。")
