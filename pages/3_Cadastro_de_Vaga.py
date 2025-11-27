import streamlit as st

from utils.data_io import append_dict_to_csv, load_csv_as_dataframe
from utils.ui import require_authentication

st.set_page_config(page_title="Cadastro de Vaga", page_icon="📝", layout="wide")

require_authentication()

st.title("Cadastro de Vaga")
st.page_link("app.py", label="Voltar para a página inicial", icon="🏠")

vagas_df = load_csv_as_dataframe("vagas.csv")

with st.form("cadastro_vaga_form"):
    col1, col2 = st.columns(2)
    with col1:
        titulo = st.text_input("Título da vaga")
        cidade = st.text_input("Cidade")
        tipo_contratacao = st.selectbox(
            "Tipo de contratação",
            sorted(vagas_df["tipo_contratacao"].unique()),
        )
        empresa = st.text_input("Empresa")
    with col2:
        descricao = st.text_area("Descrição", height=150)
        estado = st.text_input("Estado")
        salario = st.text_input("Salário", value="R$ ")
        skills = st.text_input("Skills (separadas por vírgula)")
    submitted = st.form_submit_button("Cadastrar vaga")

if submitted:
    campos_obrigatorios = [titulo, descricao, cidade, estado, tipo_contratacao, salario, empresa]
    if any(not campo for campo in campos_obrigatorios):
        st.error("Preencha todos os campos obrigatórios.")
    else:
        dados = {
            "titulo": titulo,
            "descricao": descricao,
            "cidade": cidade,
            "estado": estado,
            "tipo_contratacao": tipo_contratacao,
            "salario": salario,
            "empresa": empresa,
            "skills": skills,
        }
        append_dict_to_csv("vagas.csv", dados)
        st.success("Vaga cadastrada com sucesso! Atualize a página de listagem para visualizar.")
