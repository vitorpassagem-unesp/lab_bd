import streamlit as st

from utils.data_io import load_csv_as_dataframe
from utils.ui import require_authentication

st.set_page_config(page_title="Currículos Ativos", page_icon="📄", layout="wide")

require_authentication()

st.title("Currículos Ativos")
st.page_link("app.py", label="Voltar para a página inicial", icon="🏠")

curriculos_df = load_csv_as_dataframe("curriculos.csv")

with st.form("filtro_curriculos"):
    col1, col2, col3 = st.columns(3)
    with col1:
        idiomas = st.multiselect("Idiomas", sorted(curriculos_df["idiomas"].dropna().unique()))
    with col2:
        certificacoes = st.text_input("Certificações (palavra-chave)")
    with col3:
        experiencia = st.slider("Experiência mínima (anos)", min_value=0, max_value=20, value=0)
    skill_busca = st.text_input("Filtrar por skill específica")
    aplicar = st.form_submit_button("Aplicar filtros")

if aplicar:
    filtrado = curriculos_df.copy()
    if idiomas:
        filtrado = filtrado[filtrado["idiomas"].apply(lambda texto: any(idioma in str(texto) for idioma in idiomas))]
    if certificacoes:
        filtrado = filtrado[filtrado["certificacoes"].str.contains(certificacoes, case=False, na=False)]
    if experiencia > 0:
        filtrado = filtrado[filtrado["experiencia"].str.extract(r"(\d+)").astype(float)[0] >= experiencia]
    if skill_busca:
        filtrado = filtrado[filtrado["skills"].str.contains(skill_busca, case=False, na=False)]
    st.dataframe(filtrado, width="stretch")
else:
    st.dataframe(curriculos_df, width="stretch")
