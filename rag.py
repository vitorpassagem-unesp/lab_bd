import streamlit as st
from google import genai
from google.genai import types
from pymongo import MongoClient

# editar aqui com os dados de conexão ao mongodb e ao gemini
client_gemini = genai.Client(api_key="AIzaSyCvVxCSPtLdSOgmq9_fkV4yehsl7Av89JM")
client_atlas = MongoClient("mongodb+srv://admin:admin@labbd.tapfnsh.mongodb.net/sistema_curriculos")

def gerarEmbeddingsPerguntas(txt_query):
	
	response = client_gemini.models.embed_content(
        model="gemini-embedding-001" # modelo de geração de embedding
        , contents=txt_query # texto a ser convertido
        , config=types.EmbedContentConfig(
			task_type="RETRIEVAL_QUERY", # Importante: usar o tipo de tarefa correto para a consulta
            output_dimensionality=512) # tamanho do vetor
        )
	
	return response.embeddings[0].values

def getDocsMongodbAtlas(query_embedding):
	db = client_atlas["labbd_not"] # nome da database no Atlas
	c = db["curriculos"] # nome da Collection de Curriculos
	v = db["vagas"] # nome da Collection de Vagas

	docs = c.aggregate([
		{
		        "$vectorSearch": {
					"queryVector": query_embedding, #envia o embedding da consulta
					"path": "embedding", # restringe ao campo de embeddings
					"numCandidates": 100, # num de vizinhos mais próximos analisados
					"limit": 10, # docs  serem retornados para o resumo
					"index": "embedding" # nome do índice no Atlas (Search Indexes)
			}
		},
		{"$project": {"nome": 1, "resumo": 1, "score": {"$meta": "vectorSearchScore"}}}
	])

	return list(docs)

def gerarPrompt(docs, query):
	contexto = " ".join([doc["resumo"] + doc["nome"] for doc in docs])

	# o prompt deve ser ajustado para ser o mais assertivo possível
	prompt = f"""
	Você é um assistente prestativo. Use SOMENTE as informações fornecidas no contexto abaixo 
    para responder à pergunta do usuário. Se a resposta não estiver no contexto, diga 
    educadamente que você não tem informações sobre o assunto.

	Você também é um especialista em contratação de RH com conehcimentos técnicos 
	sobre desenvolvimento de software e suas tecnologias relacionadas.
	
	Baseado nos currículos: {contexto}
	
	Pergunta do usuário: {query}
	"""
	
	resposta = client_gemini.models.generate_content(
		model="gemini-2.5-flash" # outro modelo, aqui de geração, não de embedding
		, contents=prompt)
	
	return resposta.text

# Corpo de execução da página do Streamlit
resposta = ""
# pega consulta do usuário
with st.form("Chat: "):
	query = st.text_input("Digite sua pergunta: ")
	submit = st.form_submit_button("Enviar")
	
	if submit and query!="":
		with st.status("Realizando RAG..."):
			# converte para embedding
			st.write("Gerando embedding da pergunta")
			emb = gerarEmbeddingsPerguntas(query)
			st.write(emb)

			# consulta o mongodb
			st.write("Consultando o MongoDB Atlas")
			docs = getDocsMongodbAtlas(emb)
			st.write(docs)

			# anexa as respostas ao prompt
			st.write("Gerando prompt para síntese da resposta")
			resposta = gerarPrompt(docs, query)
	

			# retorna ao usuário
			st.success("Respondido com sucesso")
	elif submit and query=="":
		st.text("Texto vazio.")

st.markdown(resposta)
