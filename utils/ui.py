import streamlit as st

_HIDE_NAVIGATION_STYLE = """
<style>
[data-testid="stSidebarNav"] { display: none; }
</style>
"""


def ensure_session_defaults() -> None:
    if "authenticated" not in st.session_state:
        st.session_state.authenticated = False
        st.session_state.username = ""


def hide_sidebar_navigation() -> None:
    st.markdown(_HIDE_NAVIGATION_STYLE, unsafe_allow_html=True)


def require_authentication() -> None:
    ensure_session_defaults()
    if not st.session_state.authenticated:
        hide_sidebar_navigation()
        st.error("Para acessar esta página, faça login na página inicial.")
        st.page_link("app.py", label="Ir para login", icon="🔐")
        st.stop()
