import streamlit as st

from utils.data_io import load_curriculos_by_candidato
from utils.ui import require_perfil

st.set_page_config(page_title="Meus Currículos", page_icon="📄", layout="wide")

require_perfil(["candidato"])

st.title("Meus Currículos")
st.page_link("app.py", label="Voltar para a página inicial", icon="🏠")

meus_curriculos = load_curriculos_by_candidato(st.session_state.username)

if meus_curriculos.empty:
    st.info("Você ainda não cadastrou nenhum currículo.")
    st.page_link("pages/4_Candidato_-_Cadastro_de_Curriculo.py", label="Cadastrar novo currículo", icon="📝")
else:
    st.success(f"Total de currículos cadastrados: {len(meus_curriculos)}")
    st.dataframe(meus_curriculos, width="stretch")
