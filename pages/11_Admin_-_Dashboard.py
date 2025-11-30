


import streamlit as st
import pandas as pd

from utils.data_io import load_vagas, load_curriculos
from utils.ui import require_perfil

st.set_page_config(page_title="Dashboard", page_icon="📊", layout="wide")

require_perfil(["administrador"])

st.title("Dashboard e Estatísticas")
st.page_link("app.py", label="Voltar para a página inicial", icon="🏠")

# Carregar dados
vagas_df = load_vagas()
curriculos_df = load_curriculos()

# Métricas gerais
st.subheader("📈 Métricas Gerais")
col1, col2 = st.columns(2)

with col1:
    st.metric("Total de Vagas", len(vagas_df))
with col2:
    st.metric("Total de Currículos", len(curriculos_df))

st.divider()

# Distribuição geográfica das vagas
st.subheader("🗺️ Distribuição Geográfica das Vagas")

if not vagas_df.empty and "estado" in vagas_df.columns and "cidade" in vagas_df.columns:
    # Contar vagas por estado
    vagas_por_estado = vagas_df.groupby("estado").size().reset_index(name="quantidade")
    vagas_por_estado = vagas_por_estado.sort_values("quantidade", ascending=False)
    
    col1, col2 = st.columns([1, 1])
    
    with col1:
        st.bar_chart(vagas_por_estado.set_index("estado"))
    
    with col2:
        st.dataframe(vagas_por_estado, width="stretch")
    
    # Mapa de calor (coordenadas aproximadas das capitais)
    st.subheader("Mapa de Vagas")
    
    # Coordenadas aproximadas das capitais brasileiras
    coordenadas_estados = {
        "AC": (-9.0238, -70.812),
        "AL": (-9.6658, -35.7353),
        "AM": (-3.1190, -60.0217),
        "AP": (0.0349, -51.0694),
        "BA": (-12.9714, -38.5014),
        "CE": (-3.7172, -38.5433),
        "DF": (-15.7942, -47.8822),
        "ES": (-20.3155, -40.3128),
        "GO": (-16.6864, -49.2643),
        "MA": (-2.5387, -44.2825),
        "MG": (-19.9167, -43.9345),
        "MS": (-20.4486, -54.6295),
        "MT": (-15.6014, -56.0979),
        "PA": (-1.4558, -48.5044),
        "PB": (-7.1195, -34.8450),
        "PE": (-8.0476, -34.8770),
        "PI": (-5.0949, -42.8042),
        "PR": (-25.4290, -49.2671),
        "RJ": (-22.9068, -43.1729),
        "RN": (-5.7945, -35.2110),
        "RO": (-8.7612, -63.9004),
        "RR": (2.8235, -60.6758),
        "RS": (-30.0346, -51.2177),
        "SC": (-27.5954, -48.5480),
        "SE": (-10.9472, -37.0731),
        "SP": (-23.5505, -46.6333),
        "TO": (-10.1753, -48.2982),
    }
    
    # Criar DataFrame para o mapa
    mapa_data = []
    for _, row in vagas_por_estado.iterrows():
        estado = row["estado"]
        if estado in coordenadas_estados:
            lat, lon = coordenadas_estados[estado]
            mapa_data.append({
                "lat": lat,
                "lon": lon,
                "quantidade": row["quantidade"]
            })
    
    if mapa_data:
        mapa_df = pd.DataFrame(mapa_data)
        st.map(mapa_df, size="quantidade")
    else:
        st.info("Dados insuficientes para gerar o mapa.")
else:
    st.info("Nenhuma vaga cadastrada ou faltam informações de localização.")

st.divider()

# Vagas por tipo de contratação
st.subheader("💼 Vagas por Tipo de Contratação")
if not vagas_df.empty and "tipo_contratacao" in vagas_df.columns:
    tipos = vagas_df["tipo_contratacao"].value_counts()
    st.bar_chart(tipos)
else:
    st.info("Dados insuficientes.")

st.divider()

# Top empresas com mais vagas
st.subheader("🏢 Top 10 Empresas com Mais Vagas")
if not vagas_df.empty and "empresa" in vagas_df.columns:
    top_empresas = vagas_df["empresa"].value_counts().head(10)
    st.bar_chart(top_empresas)
else:
    st.info("Dados insuficientes.")

st.divider()

# Skills mais demandadas
st.subheader("🔧 Skills Mais Demandadas")
if not vagas_df.empty and "skills" in vagas_df.columns:
    all_skills = []
    for skills_str in vagas_df["skills"].dropna():
        skills = [s.strip() for s in str(skills_str).split(",")]
        all_skills.extend(skills)
    
    if all_skills:
        skills_counts = pd.Series(all_skills).value_counts().head(15)
        st.bar_chart(skills_counts)
    else:
        st.info("Nenhuma skill encontrada.")
else:
    st.info("Dados insuficientes.")
