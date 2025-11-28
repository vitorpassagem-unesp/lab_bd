import streamlit as st

from utils.data_io import add_user
from utils.ui import ensure_session_defaults, hide_sidebar_navigation

st.set_page_config(page_title="Cadastro de Usuário", page_icon="🆕")

ensure_session_defaults()

if st.session_state.authenticated:
    st.switch_page("app.py")
else:
    hide_sidebar_navigation()

st.title("Cadastro de Usuário")

st.page_link("app.py", label="Voltar para a página inicial", icon="🏠")

with st.form("cadastro_usuario_form"):
    username = st.text_input("Usuário")
    email = st.text_input("E-mail")
    perfil = st.selectbox(
        "Perfil",
        ["candidato", "empregador", "administrador"],
        help="Candidato: busca vagas | Empregador: cadastra vagas | Administrador: gerencia tudo"
    )
    password = st.text_input("Senha", type="password")
    confirm_password = st.text_input("Confirme a senha", type="password")
    submitted = st.form_submit_button("Cadastrar")

if submitted:
    if not username or not email or not password:
        st.error("Preencha todos os campos obrigatórios.")
    elif password != confirm_password:
        st.error("As senhas não conferem.")
    else:
        try:
            add_user(username=username, password=password, email=email, perfil=perfil)
        except ValueError as exc:
            st.error(str(exc))
        else:
            st.success(f"Usuário cadastrado com sucesso como {perfil}! Volte à página inicial para entrar.")
