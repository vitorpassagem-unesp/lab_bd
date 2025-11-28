import streamlit as st

_HIDE_NAVIGATION_STYLE = """
<style>
[data-testid="stSidebarNav"] { display: none; }
</style>
"""

# Mapeamento de páginas por perfil
PAGINAS_POR_PERFIL = {
    "candidato": [
        "app.py",
        "pages/1_Cadastro_de_Usuario.py",
        "pages/2_Listagem_de_Vagas.py",
        "pages/5_Cadastro_de_Curriculo.py",
        "pages/10_Meus_Curriculos.py",
        "pages/11_Minhas_Candidaturas.py",
    ],
    "empregador": [
        "app.py",
        "pages/1_Cadastro_de_Usuario.py",
        "pages/2_Listagem_de_Vagas.py",
        "pages/3_Cadastro_de_Vaga.py",
        "pages/8_Minhas_Vagas.py",
        "pages/9_Candidaturas_Recebidas.py",
    ],
    "administrador": [
        # Admin pode ver tudo
        "app.py",
        "pages/1_Cadastro_de_Usuario.py",
        "pages/2_Listagem_de_Vagas.py",
        "pages/3_Cadastro_de_Vaga.py",
        "pages/4_Listagem_de_Curriculos.py",
        "pages/5_Cadastro_de_Curriculo.py",
        "pages/6_Admin_Usuarios.py",
        "pages/7_Admin_Dashboard.py",
        "pages/8_Minhas_Vagas.py",
        "pages/9_Candidaturas_Recebidas.py",
        "pages/10_Meus_Curriculos.py",
        "pages/11_Minhas_Candidaturas.py",
    ],
}


def ensure_session_defaults() -> None:
    if "authenticated" not in st.session_state:
        st.session_state.authenticated = False
        st.session_state.username = ""
        st.session_state.perfil = ""


def hide_sidebar_navigation() -> None:
    st.markdown(_HIDE_NAVIGATION_STYLE, unsafe_allow_html=True)


# Função removida - agora usamos estrutura de pastas para organizar páginas por setor


def hide_specific_pages(page_names: list) -> None:
    """Oculta páginas específicas da barra lateral usando CSS."""
    # Criar seletores CSS para cada página
    css_rules = []
    for page_name in page_names:
        css_rules.append(f'[data-testid="stSidebarNav"] li:has(a[href*="{page_name}"])')
    
    if css_rules:
        css_selector = ",\n        ".join(css_rules)
        hide_pages_style = f"""
        <style>
        {css_selector}
        {{
            display: none !important;
        }}
        </style>
        """
        st.markdown(hide_pages_style, unsafe_allow_html=True)


def require_authentication() -> None:
    ensure_session_defaults()
    if not st.session_state.authenticated:
        hide_sidebar_navigation()
        st.error("Para acessar esta página, faça login na página inicial.")
        st.page_link("app.py", label="Ir para login", icon="🔐")
        st.stop()


def require_perfil(perfis_permitidos: list) -> None:
    """Requer que o usuário tenha um dos perfis permitidos."""
    require_authentication()
    
    if st.session_state.perfil not in perfis_permitidos:
        perfil_str = ", ".join(perfis_permitidos)
        st.error(f"Acesso negado. Esta página é apenas para: {perfil_str}")
        st.page_link("app.py", label="Voltar para a página inicial", icon="🏠")
        st.stop()
