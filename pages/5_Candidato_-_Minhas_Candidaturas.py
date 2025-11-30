import streamlit as st

from utils.data_io import load_candidaturas, get_vaga_by_id
from utils.ui import require_perfil

st.set_page_config(page_title="Minhas Candidaturas", page_icon="📬", layout="wide")

require_perfil(["candidato", "administrador"])

st.title("Minhas Candidaturas")
st.page_link("app.py", label="Voltar para a página inicial", icon="🏠")

# Carregar candidaturas do usuário
minhas_candidaturas = load_candidaturas({"candidato_username": st.session_state.username})

if not minhas_candidaturas:
    st.info("Você ainda não se candidatou a nenhuma vaga.")
    st.page_link("pages/2_Geral_-_Listagem_de_Vagas.py", label="Buscar vagas", icon="🔍")
else:
    st.success(f"Total de candidaturas: {len(minhas_candidaturas)}")
    
    for candidatura in minhas_candidaturas:
        vaga = get_vaga_by_id(candidatura.get("vaga_id"))
        
        if vaga:
            col1, col2 = st.columns([3, 1])
            
            with col1:
                st.markdown(f"### {vaga.get('titulo', 'Sem título')}")
                st.markdown(f"**Empresa:** {vaga.get('empresa', 'N/A')}")
                st.markdown(f"**Localização:** {vaga.get('cidade', 'N/A')}, {vaga.get('estado', 'N/A')}")
                st.markdown(f"**Data da candidatura:** {candidatura.get('data_candidatura', 'N/A')}")
            
            with col2:
                status = candidatura.get('status', 'pendente')
                if status == "pendente":
                    st.warning("⏳ Pendente")
                elif status == "aprovado":
                    st.success("✓ Aprovado")
                else:
                    st.error("✗ Rejeitado")
            
            st.divider()
