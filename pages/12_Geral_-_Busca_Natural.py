
import streamlit as st
import google.generativeai as genai
from pymongo import MongoClient


# === CONFIGURAÇÃO ===
# Edite aqui sua chave Gemini e string de conexão MongoDB Atlas
genai.configure(api_key="AIzaSyAefXQCKBMksD0IBXI88FfpfCoLyLNrKj0")
client_atlas = MongoClient("mongodb+srv://admin:admin@labbd.tapfnsh.mongodb.net/sistema_curriculos")
model = genai.GenerativeModel("gemini-2.0-flash-lite")


def gerarEmbeddingsPerguntas(txt_query):
    response = genai.embed_content(
        model="models/text-embedding-004",
        content=txt_query,
        task_type="RETRIEVAL_QUERY"
    )
    return response["embedding"]

def getDocsMongodbAtlas(query_embedding, base):
    db = client_atlas["labbd_not"]
    if base == "currículos":
        c = db["curriculos"]
    else:
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
        {"$project": {"nome": 1, "resumo": 1, "descricao": 1, "score": {"$meta": "vectorSearchScore"}}}
    ])
    return list(docs)


def gerarPrompt(docs, query, base):
    # Decide a base de contexto conforme o botão selecionado
    db = client_atlas["sistema_curriculos"]
    if base == "currículos":
        colecao_cursor = db["curriculos"].find({}, {"_id": 0, "resumo": 1, "candidato_nome": 1})
        colecao = list(colecao_cursor)
        print(f"[DEBUG] Currículos encontrados: {len(colecao)}")
        if colecao:
            print(f"[DEBUG] Exemplo de currículo: {colecao[0]}")
        contexto = "\n".join([f"Nome: {doc.get('candidato_nome', '')}\nResumo: {doc.get('resumo', '')}" for doc in colecao])
        base_txt = "currículos"
        orientacao = "Liste os nomes dos currículos mais compatíveis com a busca, mostrando nome e resumo."
    else:
        colecao_cursor = db["vagas"].find({}, {"_id": 0, "descricao": 1, "titulo": 1})
        colecao = list(colecao_cursor)
        print(f"[DEBUG] Vagas encontradas: {len(colecao)}")
        if colecao:
            print(f"[DEBUG] Exemplo de vaga: {colecao[0]}")
        contexto = "\n".join([f"Título: {doc.get('titulo', '')}\nDescrição: {doc.get('descricao', '')}" for doc in colecao])
        base_txt = "vagas"
        orientacao = "Liste as vagas mais compatíveis com a busca, mostrando título e descrição. Seja objetivo e retorne uma lista."
    # Exibir contexto para debug apenas no terminal
    print("\n[DEBUG] Contexto enviado ao modelo:\n" + contexto[:3000])
    prompt = f"""
Você é um assistente prestativo. Use SOMENTE as informações fornecidas no contexto abaixo 
para responder à pergunta do usuário. Se a resposta não estiver no contexto, diga 
educadamente que você não tem informações sobre o assunto.

Você também é um especialista em contratação de RH com conhecimentos técnicos 
sobre desenvolvimento de software e suas tecnologias relacionadas.

{orientacao}

Base de dados ({base_txt}):\n{contexto}

Pergunta do usuário: {query}
"""
    resposta = model.generate_content(prompt)
    return resposta.text

# === INTERFACE STREAMLIT ===
st.set_page_config(page_title="Busca Inteligente (RAG)", page_icon="🤖")
st.title("Busca em Linguagem Natural (RAG)")

base = st.radio("Buscar em qual base?", ["vagas", "currículos"])
resposta = ""

with st.form("Chat: "):
    query = st.text_input("Digite sua pergunta:")
    submit = st.form_submit_button("Enviar")
    if submit and query:
        with st.status("Realizando RAG..."):
            st.write("Gerando embedding da pergunta...")
            emb = gerarEmbeddingsPerguntas(query)
            st.write("Consultando o MongoDB Atlas...")
            docs = getDocsMongodbAtlas(emb, base)
            st.write("Gerando resposta...")
            resposta = gerarPrompt(docs, query, base)
            st.success("Respondido com sucesso!")
    elif submit and not query:
        st.warning("Texto vazio.")

if resposta:
    st.markdown("**Resposta:**")
    st.write(resposta)
