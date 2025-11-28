import streamlit as st
import pandas as pd

from utils.data_io import load_vagas_by_empregador, load_candidaturas, get_curriculo_by_id
from utils.ui import require_perfil

st.set_page_config(page_title="Candidaturas Recebidas", page_icon="👥", layout="wide")

require_perfil(["empregador", "administrador"])

st.title("Candidaturas Recebidas")
st.page_link("app.py", label="Voltar para a página inicial", icon="🏠")

# Carregar vagas do empregador
minhas_vagas = load_vagas_by_empregador(st.session_state.username)

if minhas_vagas.empty:
    st.info("Você ainda não cadastrou nenhuma vaga.")
    st.page_link("pages/6_Empregador_-_Cadastro_de_Vaga.py", label="Cadastrar nova vaga", icon="➕")
    st.stop()

# Listar IDs das vagas
meus_vaga_ids = minhas_vagas["id"].tolist() if "id" in minhas_vagas.columns else []

if not meus_vaga_ids:
    st.warning("Suas vagas não possuem IDs válidos.")
    st.stop()

# Carregar todas as candidaturas
todas_candidaturas = load_candidaturas()

# Filtrar candidaturas para minhas vagas
minhas_candidaturas = [c for c in todas_candidaturas if c.get("vaga_id") in meus_vaga_ids]

if not minhas_candidaturas:
    st.info("Nenhuma candidatura recebida ainda.")
else:
    st.success(f"Total de candidaturas recebidas: {len(minhas_candidaturas)}")
    
    # Agrupar por vaga
    for vaga_id in meus_vaga_ids:
        candidaturas_vaga = [c for c in minhas_candidaturas if c.get("vaga_id") == vaga_id]
        
        if candidaturas_vaga:
            vaga_info = minhas_vagas[minhas_vagas["id"] == vaga_id].iloc[0]
            vaga_titulo = vaga_info.get("titulo", "Sem título")
            
            with st.expander(f"📋 {vaga_titulo} ({len(candidaturas_vaga)} candidaturas)", expanded=True):
                for candidatura in candidaturas_vaga:
                    col1, col2 = st.columns([3, 1])
                    
                    with col1:
                        st.markdown(f"**Candidato:** {candidatura.get('candidato_username')}")
                        st.markdown(f"**Data:** {candidatura.get('data_candidatura', 'N/A')}")
                        
                        # Buscar detalhes do currículo
                        curriculo = get_curriculo_by_id(candidatura.get('curriculo_id'))
                        if curriculo:
                            st.markdown(f"**Nome:** {curriculo.get('nome', 'N/A')}")
                            st.markdown(f"**Email:** {curriculo.get('email', 'N/A')}")
                            st.markdown(f"**Experiência:** {curriculo.get('experiencia', 'N/A')}")
                            st.markdown(f"**Skills:** {curriculo.get('skills', 'N/A')}")
                    
                    with col2:
                        status = candidatura.get('status', 'pendente')
                        if status == "pendente":
                            st.warning("⏳ Pendente")
                        elif status == "aprovado":
                            st.success("✓ Aprovado")
                        else:
                            st.error("✗ Rejeitado")
                    
                    st.divider()
