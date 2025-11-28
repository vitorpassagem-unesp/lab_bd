import streamlit as st

from utils.data_io import load_curriculos
from utils.ui import require_perfil

st.set_page_config(page_title="Currículos Ativos", page_icon="📄", layout="wide")

require_perfil(["administrador"])

st.title("Currículos Ativos (Visão Administrativa)")
st.page_link("app.py", label="Voltar para a página inicial", icon="🏠")

curriculos_df = load_curriculos()

if curriculos_df.empty:
    st.info("Nenhum currículo cadastrado ainda.")
    st.stop()

# Verificar colunas disponíveis
col_idiomas = "idiomas" if "idiomas" in curriculos_df.columns else None
col_certificacoes = "certificacoes" if "certificacoes" in curriculos_df.columns else None
col_experiencia = "experiencia" if "experiencia" in curriculos_df.columns else None
col_skills = "skills" if "skills" in curriculos_df.columns else None

with st.form("filtro_curriculos"):
    col1, col2, col3 = st.columns(3)
    with col1:
        if col_idiomas:
            idiomas = st.multiselect("Idiomas", sorted(curriculos_df[col_idiomas].dropna().unique()))
        else:
            idiomas = []
    with col2:
        certificacoes = st.text_input("Certificações (palavra-chave)")
    with col3:
        experiencia = st.slider("Experiência mínima (anos)", min_value=0, max_value=20, value=0)
    skill_busca = st.text_input("Filtrar por skill específica")
    aplicar = st.form_submit_button("Aplicar filtros")

if aplicar:
    filtrado = curriculos_df.copy()
    if idiomas and col_idiomas:
        filtrado = filtrado[filtrado[col_idiomas].apply(lambda texto: any(idioma in str(texto) for idioma in idiomas))]
    if certificacoes and col_certificacoes:
        filtrado = filtrado[filtrado[col_certificacoes].str.contains(certificacoes, case=False, na=False)]
    if experiencia > 0 and col_experiencia:
        # Tentar extrair número de anos da experiência
        try:
            filtrado = filtrado[filtrado[col_experiencia].str.extract(r"(\d+)").astype(float)[0] >= experiencia]
        except:
            pass  # Se falhar, não aplica este filtro
    if skill_busca and col_skills:
        filtrado = filtrado[filtrado[col_skills].str.contains(skill_busca, case=False, na=False)]
    st.dataframe(filtrado, width="stretch")
else:
    st.dataframe(curriculos_df, width="stretch")
