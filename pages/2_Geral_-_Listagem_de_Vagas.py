import streamlit as st

from utils.data_io import load_vagas, calcular_score_curriculo, load_curriculos
from utils.ui import ensure_session_defaults

st.set_page_config(page_title="Vagas Abertas", page_icon="📋", layout="wide")

ensure_session_defaults()

st.title("Vagas Abertas")
st.page_link("app.py", label="Voltar para a página inicial", icon="🏠")



# Carregar vagas e padronizar campo de id, empresa e skills
vagas_df = load_vagas()
if '_id' in vagas_df.columns:
    vagas_df['id'] = vagas_df['_id'].astype(str)
elif 'id' in vagas_df.columns:
    vagas_df['id'] = vagas_df['id'].astype(str)

# Preencher coluna empresa se não existir ou se estiver vazia
if 'empresa' not in vagas_df.columns:
    vagas_df['empresa'] = vagas_df.get('empresa_nome', 'N/A')
else:
    vagas_df['empresa'] = vagas_df['empresa'].fillna(vagas_df.get('empresa_nome', 'N/A'))
if 'empresa_nome' in vagas_df.columns:
    vagas_df['empresa'] = vagas_df['empresa'].combine_first(vagas_df['empresa_nome'])
vagas_df['empresa'] = vagas_df['empresa'].fillna('N/A')



# Normalização robusta das colunas empresa e skills
def normalizar_empresa(row):
    if pd.notnull(row.get('empresa_nome')):
        return str(row['empresa_nome'])
    if pd.notnull(row.get('empresa')):
        return str(row['empresa'])
    return 'N/A'

def normalizar_skills(row):
    # Tenta skills (string ou lista)
    val = row.get('skills')
    if isinstance(val, list):
        return ', '.join(map(str, val))
    if isinstance(val, str) and val.strip():
        return val
    # Tenta habilidades (string ou lista)
    val = row.get('habilidades')
    if isinstance(val, list):
        return ', '.join(map(str, val))
    if isinstance(val, str) and val.strip():
        return val
    return 'N/A'


import pandas as pd
vagas_df['empresa'] = vagas_df.apply(normalizar_empresa, axis=1)
vagas_df['skills'] = vagas_df.apply(normalizar_skills, axis=1)

# Recalcula colunas de filtro após normalização
col_estado = "estado" if "estado" in vagas_df.columns else None
col_tipo = "tipo_contratacao" if "tipo_contratacao" in vagas_df.columns else None
col_empresa = "empresa" if "empresa" in vagas_df.columns else None
col_skills = "skills" if "skills" in vagas_df.columns else None
col_skills = "skills" if "skills" in vagas_df.columns else None

with st.form("filtro_vagas"):
    col1, col2, col3 = st.columns(3)
    with col1:
        if col_estado:
            estados = st.multiselect("Estados", sorted(vagas_df[col_estado].dropna().unique()))
        else:
            estados = []
    with col2:
        if col_tipo:
            tipos = st.multiselect("Tipos de contratação", sorted(vagas_df[col_tipo].dropna().unique()))
        else:
            tipos = []
    with col3:
        if col_empresa:
            empresas = st.multiselect("Empresas", sorted(vagas_df[col_empresa].dropna().unique()))
        else:
            empresas = []
    skill_busca = st.text_input("Filtrar por skill específica")
    aplicar_filtro = st.form_submit_button("Aplicar filtros")


# --- Corrigir coluna salario para evitar erro Arrow ---
def formatar_salario_para_str(df):
    if 'salario' in df.columns:
        df['salario'] = df['salario'].astype(str)
    return df


if aplicar_filtro:
    filtrado = vagas_df.copy()
    if estados and col_estado:
        filtrado = filtrado[filtrado[col_estado].isin(estados)]
    if tipos and col_tipo:
        filtrado = filtrado[filtrado[col_tipo].isin(tipos)]
    if empresas and col_empresa:
        filtrado = filtrado[filtrado[col_empresa].isin(empresas)]
    if skill_busca and col_skills:
        filtrado = filtrado[filtrado[col_skills].str.contains(skill_busca, case=False, na=False)]
    vagas_exibir = formatar_salario_para_str(filtrado)
else:
    vagas_exibir = formatar_salario_para_str(vagas_df)

st.dataframe(vagas_exibir, width="stretch")

# === BUSCA NATURAL POR VAGAS (RAG) ===
import google.generativeai as genai
from pymongo import MongoClient

# Configuração Gemini e MongoDB Atlas (ajuste se necessário)
genai.configure(api_key="AIzaSyAefXQCKBMksD0IBXI88FfpfCoLyLNrKj0")
client_atlas = MongoClient("mongodb+srv://admin:admin@labbd.tapfnsh.mongodb.net/sistema_curriculos")
model = genai.GenerativeModel("gemini-2.0-flash-lite")

def gerarEmbeddingsPerguntas_vagas(txt_query):
    response = genai.embed_content(
        model="models/text-embedding-004",
        content=txt_query,
        task_type="RETRIEVAL_QUERY"
    )
    return response["embedding"]

def getDocsMongodbAtlas_vagas(query_embedding):
    db = client_atlas["labbd_not"]
    c = db["vagas"]
    docs = c.aggregate([
        {
            "$vectorSearch": {
                "queryVector": query_embedding,
                "path": "embedding",
                "numCandidates": 100,
                "limit": 10,
                "index": "embedding"
            }
        },
        {"$project": {"titulo": 1, "descricao": 1, "score": {"$meta": "vectorSearchScore"}}}
    ])
    return list(docs)

def gerarPrompt_vagas(docs, query):
    db = client_atlas["sistema_curriculos"]
    colecao_cursor = db["vagas"].find({}, {"_id": 0, "descricao": 1, "titulo": 1})
    colecao = list(colecao_cursor)
    print(f"[DEBUG] Vagas encontradas: {len(colecao)}")
    if colecao:
        print(f"[DEBUG] Exemplo de vaga: {colecao[0]}")
    contexto = "\n".join([f"Título: {doc.get('titulo', '')}\nDescrição: {doc.get('descricao', '')}" for doc in colecao])
    print("\n[DEBUG] Contexto enviado ao modelo:\n" + contexto[:3000])
    prompt = f"""
Você é um assistente prestativo. Use SOMENTE as informações fornecidas no contexto abaixo 
para responder à pergunta do usuário. Se a resposta não estiver no contexto, diga 
educadamente que você não tem informações sobre o assunto.

Você também é um especialista em contratação de RH com conhecimentos técnicos 
sobre desenvolvimento de software e suas tecnologias relacionadas.

Liste as vagas mais compatíveis com a busca, mostrando título e descrição. Seja objetivo e retorne uma lista.

Base de dados (vagas):\n{contexto}

Pergunta do usuário: {query}
"""
    resposta = model.generate_content(prompt)
    return resposta.text

# Interface de busca natural
st.divider()
st.subheader("Busca Natural em Vagas (RAG)")
rag_resposta = ""
with st.form("busca_natural_vagas"):
    rag_query = st.text_input("Digite sua pergunta sobre vagas:")
    rag_submit = st.form_submit_button("Buscar")
    if rag_submit and rag_query:
        with st.status("Realizando busca inteligente..."):
            st.write("Gerando embedding da pergunta...")
            emb = gerarEmbeddingsPerguntas_vagas(rag_query)
            st.write("Consultando o MongoDB Atlas...")
            docs = getDocsMongodbAtlas_vagas(emb)
            st.write("Gerando resposta...")
            rag_resposta = gerarPrompt_vagas(docs, rag_query)
            st.success("Busca concluída!")
    elif rag_submit and not rag_query:
        st.warning("Texto vazio.")

if rag_resposta:
    st.markdown("**Resposta da busca natural:**")
    st.write(rag_resposta)
