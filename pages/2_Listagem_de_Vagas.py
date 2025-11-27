import streamlit as st

from utils.data_io import load_csv_as_dataframe
from utils.ui import require_authentication

st.set_page_config(page_title="Vagas Abertas", page_icon="📋", layout="wide")

require_authentication()

st.title("Vagas Abertas")
st.page_link("app.py", label="Voltar para a página inicial", icon="🏠")

vagas_df = load_csv_as_dataframe("vagas.csv")

with st.form("filtro_vagas"):
    col1, col2, col3 = st.columns(3)
    with col1:
        estados = st.multiselect("Estados", sorted(vagas_df["estado"].unique()))
    with col2:
        tipos = st.multiselect("Tipos de contratação", sorted(vagas_df["tipo_contratacao"].unique()))
    with col3:
        empresas = st.multiselect("Empresas", sorted(vagas_df["empresa"].unique()))
    skill_busca = st.text_input("Filtrar por skill específica")
    aplicar_filtro = st.form_submit_button("Aplicar filtros")

if aplicar_filtro:
    filtrado = vagas_df.copy()
    if estados:
        filtrado = filtrado[filtrado["estado"].isin(estados)]
    if tipos:
        filtrado = filtrado[filtrado["tipo_contratacao"].isin(tipos)]
    if empresas:
        filtrado = filtrado[filtrado["empresa"].isin(empresas)]
    if skill_busca:
        filtrado = filtrado[filtrado["skills"].str.contains(skill_busca, case=False, na=False)]
    st.dataframe(filtrado, width="stretch")
else:
    st.dataframe(vagas_df, width="stretch")
