import streamlit as st

from utils.data_io import validate_credentials
from utils.ui import ensure_session_defaults, hide_sidebar_navigation

st.set_page_config(page_title="Portal de Oportunidades", page_icon="💼", layout="wide")

ensure_session_defaults()

st.title("Portal de Oportunidades")

# Permitir visualização de vagas sem login
st.subheader("🔍 Vagas Disponíveis")
st.page_link("pages/2_Geral_-_Listagem_de_Vagas.py", label="Ver vagas abertas (não requer login)", icon="📋")
st.divider()

if st.session_state.authenticated:
    user_perfil = st.session_state.get("perfil", "candidato")
    st.success(f"Bem-vindo, {st.session_state.username}! (Perfil: {user_perfil})")
    
    # Menu baseado no perfil
    if user_perfil == "administrador":
        st.subheader("🔧 Painel do Administrador")
        st.info("Como administrador, você tem acesso total ao sistema através do menu lateral.")
        col1, col2 = st.columns(2)
        with col1:
            st.page_link("pages/10_Admin_-_Gerenciar_Usuarios.py", label="👥 Gerenciar Usuários")
            st.page_link("pages/11_Admin_-_Dashboard.py", label="📊 Dashboard e Estatísticas")
        with col2:
            st.page_link("pages/2_Geral_-_Listagem_de_Vagas.py", label="📋 Ver todas as vagas")
            st.page_link("pages/9_Admin_-_Listagem_de_Curriculos.py", label="📄 Ver todos os currículos")
    
    elif user_perfil == "empregador":
        st.subheader("💼 Painel do Empregador")
        col1, col2 = st.columns(2)
        with col1:
            st.page_link("pages/6_Empregador_-_Cadastro_de_Vaga.py", label="➕ Cadastrar nova vaga")
            st.page_link("pages/7_Empregador_-_Minhas_Vagas.py", label="📋 Minhas vagas")
        with col2:
            st.page_link("pages/8_Empregador_-_Candidaturas_Recebidas.py", label="👥 Ver candidaturas recebidas")
            st.page_link("pages/2_Geral_-_Listagem_de_Vagas.py", label="🔍 Buscar vagas com ranking de currículos")
    
    elif user_perfil == "candidato":
        st.subheader("👤 Painel do Candidato")
        col1, col2 = st.columns(2)
        with col1:
            st.page_link("pages/4_Candidato_-_Cadastro_de_Curriculo.py", label="📝 Cadastrar currículo")
            st.page_link("pages/3_Candidato_-_Meus_Curriculos.py", label="📄 Meus currículos")
        with col2:
            st.page_link("pages/2_Geral_-_Listagem_de_Vagas.py", label="🔍 Buscar vagas")
            st.page_link("pages/5_Candidato_-_Minhas_Candidaturas.py", label="📬 Minhas candidaturas")
    
    st.divider()
    if st.button("Sair", type="primary"):
        st.session_state.authenticated = False
        st.session_state.username = ""
        st.session_state.perfil = ""
        st.rerun()
else:
    hide_sidebar_navigation()
    st.subheader("🔐 Acesse sua conta")
    with st.form("login_form", clear_on_submit=False):
        username = st.text_input("Usuário")
        password = st.text_input("Senha", type="password")
        submitted = st.form_submit_button("Entrar")

    if submitted:
        user = validate_credentials(username, password)
        if user:
            st.session_state.authenticated = True
            st.session_state.username = username
            st.session_state.perfil = user.get("perfil", "candidato")
            st.rerun()
        else:
            st.error("Credenciais inválidas. Tente novamente.")

    st.divider()
    st.caption("Ainda não tem cadastro?")
    st.page_link("pages/1_Geral_-_Cadastro_de_Usuario.py", label="Criar nova conta", icon="👤")
