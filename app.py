import streamlit as st

from utils.data_io import validate_credentials
from utils.ui import ensure_session_defaults, hide_sidebar_navigation

st.set_page_config(page_title="Portal de Oportunidades", page_icon="💼", layout="wide")

ensure_session_defaults()

st.title("Portal de Oportunidades")

if st.session_state.authenticated:
    st.success(f"Bem-vindo, {st.session_state.username}!")
    st.page_link("pages/2_Listagem_de_Vagas.py", label="Ver vagas abertas")
    st.page_link("pages/3_Cadastro_de_Vaga.py", label="Cadastrar nova vaga")
    st.page_link("pages/4_Listagem_de_Curriculos.py", label="Ver currículos ativos")
    st.page_link("pages/5_Cadastro_de_Curriculo.py", label="Cadastrar novo currículo")

    if st.button("Sair"):
        st.session_state.authenticated = False
        st.session_state.username = ""
        st.rerun()
else:
    hide_sidebar_navigation()
    st.subheader("Acesse sua conta")
    with st.form("login_form", clear_on_submit=False):
        username = st.text_input("Usuário")
        password = st.text_input("Senha", type="password")
        submitted = st.form_submit_button("Entrar")

    if submitted:
        if validate_credentials(username, password):
            st.session_state.authenticated = True
            st.session_state.username = username
            st.rerun()
        else:
            st.error("Credenciais inválidas. Tente novamente.")

    st.divider()
    st.caption("Ainda não tem cadastro?")
    st.page_link("pages/1_Cadastro_de_Usuario.py", label="Criar nova conta", icon="👤")
