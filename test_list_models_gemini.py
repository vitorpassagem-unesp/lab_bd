import google.generativeai as genai

# Configure sua chave Gemini
API_KEY = "AIzaSyAefXQCKBMksD0IBXI88FfpfCoLyLNrKj0"
genai.configure(api_key=API_KEY)

print("Modelos disponíveis na API Gemini:")
for model in genai.list_models():
    print("-", model)
