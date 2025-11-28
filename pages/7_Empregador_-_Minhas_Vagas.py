import streamlit as st

from utils.data_io import load_vagas_by_empregador
from utils.ui import require_perfil

st.set_page_config(page_title="Minhas Vagas", page_icon="📋", layout="wide")

require_perfil(["empregador", "administrador"])

st.title("Minhas Vagas")
st.page_link("app.py", label="Voltar para a página inicial", icon="🏠")

minhas_vagas = load_vagas_by_empregador(st.session_state.username)

if minhas_vagas.empty:
    st.info("Você ainda não cadastrou nenhuma vaga.")
    st.page_link("pages/6_Empregador_-_Cadastro_de_Vaga.py", label="Cadastrar nova vaga", icon="➕")
else:
    st.success(f"Total de vagas cadastradas: {len(minhas_vagas)}")
    st.dataframe(minhas_vagas, width="stretch")
