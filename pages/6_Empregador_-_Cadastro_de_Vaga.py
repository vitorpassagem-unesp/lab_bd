import streamlit as st
import uuid

from utils.data_io import add_vaga
from utils.ui import require_perfil

st.set_page_config(page_title="Cadastro de Vaga", page_icon="📝", layout="wide")

require_perfil(["empregador", "administrador"])

st.title("Cadastro de Vaga")
st.page_link("app.py", label="Voltar para a página inicial", icon="🏠")

# Opções padrão
TIPOS_CONTRATACAO = ["CLT", "PJ", "Estágio", "Temporário"]
ESTADOS_BRASIL = ["AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO", "MA", "MT", "MS", "MG", 
                  "PA", "PB", "PR", "PE", "PI", "RJ", "RN", "RS", "RO", "RR", "SC", "SP", "SE", "TO"]

with st.form("cadastro_vaga_form"):
    col1, col2 = st.columns(2)
    with col1:
        titulo = st.text_input("Título da vaga")
        cidade = st.text_input("Cidade")
        tipo_contratacao = st.selectbox(
            "Tipo de contratação",
            TIPOS_CONTRATACAO,
        )
        empresa = st.text_input("Empresa")
    with col2:
        descricao = st.text_area("Descrição", height=150)
        estado = st.selectbox("Estado", ESTADOS_BRASIL)
        salario = st.text_input("Salário", value="R$ ")
        skills = st.text_input("Skills (separadas por vírgula)")
    submitted = st.form_submit_button("Cadastrar vaga")

if submitted:
    campos_obrigatorios = [titulo, descricao, cidade, estado, tipo_contratacao, salario, empresa]
    if any(not campo for campo in campos_obrigatorios):
        st.error("Preencha todos os campos obrigatórios.")
    else:
        dados = {
            "id": str(uuid.uuid4()),  # ID único para a vaga
            "titulo": titulo,
            "descricao": descricao,
            "cidade": cidade,
            "estado": estado,
            "tipo_contratacao": tipo_contratacao,
            "salario": salario,
            "empresa": empresa,
            "skills": skills,
            "criado_por": st.session_state.username,  # Associar ao empregador
        }
        add_vaga(dados)
        st.success("Vaga cadastrada com sucesso! Atualize a página de listagem para visualizar.")
