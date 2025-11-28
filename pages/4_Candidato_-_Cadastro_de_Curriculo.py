import streamlit as st

from utils.data_io import add_curriculo, load_users
from utils.ui import require_perfil

st.set_page_config(page_title="Cadastro de Currículo", page_icon="🧾", layout="wide")

require_perfil(["candidato", "administrador"])

st.title("Cadastro de Currículo")
st.page_link("app.py", label="Voltar para a página inicial", icon="🏠")

usuarios = load_users()
contatos_por_id = {str(indice + 1): usuario for indice, usuario in enumerate(usuarios)}
contatos_opcoes = list(contatos_por_id.keys())

# Estados do Brasil
ESTADOS_BRASIL = ["AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO", "MA", "MT", "MS", "MG", 
                  "PA", "PB", "PR", "PE", "PI", "RJ", "RN", "RS", "RO", "RR", "SC", "SP", "SE", "TO"]

with st.form("cadastro_curriculo_form"):
    st.subheader("Informações básicas")
    col1, col2, col3 = st.columns(3)
    with col1:
        candidato_id = st.number_input("ID", min_value=1, step=1)
        nome = st.text_input("Nome completo")
        cidade = st.text_input("Cidade")
    with col2:
        email = st.text_input("E-mail")
        telefone = st.text_input("Telefone")
        estado = st.selectbox("Estado", ESTADOS_BRASIL)
    with col3:
        formacao = st.text_input("Formação")
        experiencia = st.text_input("Experiência (ex: '5 anos como desenvolvedor')")

    st.subheader("Destaques")
    col4, col5 = st.columns(2)
    with col4:
        skills = st.text_area("Skills (separadas por vírgula)", height=120)
        idiomas = st.text_input("Idiomas")
        certificacoes = st.text_area("Certificações", height=100)
    with col5:
        resumo = st.text_area("Resumo profissional", height=180)
        empresas_previas = st.text_area("Empresas prévias", height=100)
        if contatos_opcoes:
            ids_contatos = st.multiselect(
                "Contatos relacionados",
                options=contatos_opcoes,
                format_func=lambda valor: f"{contatos_por_id[valor]['username']} (ID: {valor})",
            )
        else:
            st.info("Cadastre usuários na página inicial para vinculá-los como contatos.")
            ids_contatos = []

    submitted = st.form_submit_button("Cadastrar currículo")

if submitted:
    campos_obrigatorios = [
        candidato_id,
        nome,
        email,
        telefone,
        formacao,
        experiencia,
        skills,
        idiomas,
        certificacoes,
        resumo,
        empresas_previas,
        cidade,
        estado,
    ]
    if any(not str(campo).strip() for campo in campos_obrigatorios) or not ids_contatos:
        st.error("Preencha todos os campos e selecione ao menos um contato.")
    else:
        registro = {
            "id": int(candidato_id),
            "nome": nome,
            "email": email,
            "telefone": telefone,
            "cidade": cidade,
            "estado": estado,
            "formacao": formacao,
            "experiencia": experiencia,
            "skills": skills,
            "idiomas": idiomas,
            "certificacoes": certificacoes,
            "resumo": resumo,
            "empresas_previas": empresas_previas,
            "ids_contatos": ", ".join(ids_contatos),
            "criado_por": st.session_state.username,  # Associar ao candidato
        }
        add_curriculo(registro)
        st.success("Currículo cadastrado com sucesso! Confira a listagem para validar os dados.")
