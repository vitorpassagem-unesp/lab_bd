import streamlit as st
import pandas as pd

from utils.data_io import load_users
from utils.ui import require_perfil

st.set_page_config(page_title="Gerenciar Usuários", page_icon="👥", layout="wide")

require_perfil(["administrador"])

st.title("Gerenciamento de Usuários")
st.page_link("app.py", label="Voltar para a página inicial", icon="🏠")

usuarios = load_users()

if not usuarios:
    st.info("Nenhum usuário cadastrado.")
else:
    st.success(f"Total de usuários: {len(usuarios)}")
    
    # Converter para DataFrame
    df_usuarios = pd.DataFrame(usuarios)
    
    # Ocultar senha na visualização
    if "password" in df_usuarios.columns:
        df_usuarios_display = df_usuarios.copy()
        df_usuarios_display["password"] = "****"
        st.dataframe(df_usuarios_display, width="stretch")
    else:
        st.dataframe(df_usuarios, width="stretch")
    
    # Estatísticas por perfil
    st.divider()
    st.subheader("Estatísticas")
    
    if "perfil" in df_usuarios.columns:
        perfis = df_usuarios["perfil"].value_counts()
        col1, col2, col3 = st.columns(3)
        
        with col1:
            st.metric("Candidatos", perfis.get("candidato", 0))
        with col2:
            st.metric("Empregadores", perfis.get("empregador", 0))
        with col3:
            st.metric("Administradores", perfis.get("administrador", 0))
