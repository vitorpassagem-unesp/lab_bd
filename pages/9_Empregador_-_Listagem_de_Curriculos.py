import streamlit as st

from utils.data_io import load_curriculos
from utils.ui import require_perfil

st.set_page_config(page_title="Currículos Ativos", page_icon="📄", layout="wide")

require_perfil(["administrador", "empregador"])

st.title("Currículos Ativos")
st.page_link("app.py", label="Voltar para a página inicial", icon="🏠")

curriculos_df = load_curriculos()

if curriculos_df.empty:
    st.info("Nenhum currículo cadastrado ainda.")
    st.stop()

# Verificar colunas disponíveis
col_idiomas = "idiomas" if "idiomas" in curriculos_df.columns else None
col_certificacoes = "certificacoes" if "certificacoes" in curriculos_df.columns else None
col_experiencia = "experiencia" if "experiencia" in curriculos_df.columns else None
col_skills = "skills" if "skills" in curriculos_df.columns else None

with st.form("filtro_curriculos"):
    col1, col2, col3 = st.columns(3)
    with col1:
        if col_idiomas:
            idiomas = st.multiselect("Idiomas", sorted(curriculos_df[col_idiomas].dropna().unique()))
        else:
            idiomas = []
    with col2:
        certificacoes = st.text_input("Certificações (palavra-chave)")
    with col3:
        experiencia = st.slider("Experiência mínima (anos)", min_value=0, max_value=20, value=0)
    skill_busca = st.text_input("Filtrar por skill específica")
    aplicar = st.form_submit_button("Aplicar filtros")

if aplicar:
    filtrado = curriculos_df.copy()
    if idiomas and col_idiomas:
        filtrado = filtrado[filtrado[col_idiomas].apply(lambda texto: any(idioma in str(texto) for idioma in idiomas))]
    if certificacoes and col_certificacoes:
        filtrado = filtrado[filtrado[col_certificacoes].str.contains(certificacoes, case=False, na=False)]
    if experiencia > 0 and col_experiencia:
        # Tentar extrair número de anos da experiência
        try:
            filtrado = filtrado[filtrado[col_experiencia].str.extract(r"(\d+)").astype(float)[0] >= experiencia]
        except:
            pass  # Se falhar, não aplica este filtro
    if skill_busca and col_skills:
        filtrado = filtrado[filtrado[col_skills].str.contains(skill_busca, case=False, na=False)]
    st.dataframe(filtrado, width="stretch")
else:
    st.dataframe(curriculos_df, width="stretch")

    # === BUSCA NATURAL POR CURRÍCULOS (RAG) ===
    import google.generativeai as genai
    from pymongo import MongoClient

    # Configuração Gemini e MongoDB Atlas (ajuste se necessário)
    genai.configure(api_key="AIzaSyAefXQCKBMksD0IBXI88FfpfCoLyLNrKj0")
    client_atlas = MongoClient("mongodb+srv://admin:admin@labbd.tapfnsh.mongodb.net/sistema_curriculos")
    model = genai.GenerativeModel("gemini-2.0-flash-lite")

    def gerarEmbeddingsPerguntas_curriculos(txt_query):
        response = genai.embed_content(
            model="models/text-embedding-004",
            content=txt_query,
            task_type="RETRIEVAL_QUERY"
        )
        return response["embedding"]

    def getDocsMongodbAtlas_curriculos(query_embedding):
        db = client_atlas["labbd_not"]
        c = db["curriculos"]
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
            {"$project": {"candidato_nome": 1, "resumo": 1, "score": {"$meta": "vectorSearchScore"}}}
        ])
        return list(docs)

    def gerarPrompt_curriculos(docs, query):
        db = client_atlas["sistema_curriculos"]
        colecao_cursor = db["curriculos"].find({}, {"_id": 0, "resumo": 1, "candidato_nome": 1})
        colecao = list(colecao_cursor)
        print(f"[DEBUG] Currículos encontrados: {len(colecao)}")
        if colecao:
            print(f"[DEBUG] Exemplo de currículo: {colecao[0]}")
        contexto = "\n".join([f"Nome: {doc.get('candidato_nome', '')}\nResumo: {doc.get('resumo', '')}" for doc in colecao])
        print("\n[DEBUG] Contexto enviado ao modelo:\n" + contexto[:3000])
        prompt = f"""
    Você é um assistente prestativo. Use SOMENTE as informações fornecidas no contexto abaixo 
    para responder à pergunta do usuário. Se a resposta não estiver no contexto, diga 
    educadamente que você não tem informações sobre o assunto.

    Você também é um especialista em contratação de RH com conhecimentos técnicos 
    sobre desenvolvimento de software e suas tecnologias relacionadas.

    Liste os nomes dos currículos mais compatíveis com a busca, mostrando nome e resumo.

    Base de dados (currículos):\n{contexto}

    Pergunta do usuário: {query}
    """
        resposta = model.generate_content(prompt)
        return resposta.text

    # Interface de busca natural
    st.divider()
    st.subheader("Busca Natural em Currículos (RAG)")
    rag_resposta = ""
    with st.form("busca_natural_curriculos"):
        rag_query = st.text_input("Digite sua pergunta sobre currículos:")
        rag_submit = st.form_submit_button("Buscar")
        if rag_submit and rag_query:
            with st.status("Realizando busca inteligente..."):
                st.write("Gerando embedding da pergunta...")
                emb = gerarEmbeddingsPerguntas_curriculos(rag_query)
                st.write("Consultando o MongoDB Atlas...")
                docs = getDocsMongodbAtlas_curriculos(emb)
                st.write("Gerando resposta...")
                rag_resposta = gerarPrompt_curriculos(docs, rag_query)
                st.success("Busca concluída!")
        elif rag_submit and not rag_query:
            st.warning("Texto vazio.")

    if rag_resposta:
        st.markdown("**Resposta da busca natural:**")
        st.write(rag_resposta)
