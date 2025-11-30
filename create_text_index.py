"""
Script para criar índice de Full Text Search no MongoDB para matching de currículos e vagas.

Este índice é essencial para o sistema de pontuação automática que calcula
a compatibilidade entre currículos e vagas.
"""

from pymongo import MongoClient, TEXT

# Conectar ao MongoDB
client = MongoClient("mongodb+srv://admin:admin@labbd.tapfnsh.mongodb.net/sistema_curriculos")
db = client["sistema_curriculos"]

# Criar índice de texto na coleção de currículos
# Campos indexados: skills, formacao, experiencia, resumo, certificacoes
curriculos_collection = db["curriculos"]

print("Criando índice de Full Text Search na coleção 'curriculos'...")

try:
    # Verificar se já existe um índice de texto
    indexes = curriculos_collection.list_indexes()
    text_index_exists = False
    
    for index in indexes:
        if "textIndexVersion" in index:
            print("Índice de texto já existe. Removendo para recriar...")
            curriculos_collection.drop_index(index["name"])
            text_index_exists = True
            break
    
    # Criar índice de texto composto
    curriculos_collection.create_index([
        ("skills", TEXT),
        ("formacao", TEXT),
        ("experiencia", TEXT),
        ("resumo", TEXT),
        ("certificacoes", TEXT)
    ], name="curriculos_text_index", default_language="portuguese")
    
    print("✅ Índice de Full Text Search criado com sucesso!")
    print("\nCampos indexados:")
    print("  - skills (habilidades técnicas)")
    print("  - formacao (graduação, cursos)")
    print("  - experiencia (histórico profissional)")
    print("  - resumo (descrição profissional)")
    print("  - certificacoes (certificados e cursos)")
    print("\nIdioma: Português (portuguese)")
    
except Exception as e:
    print(f"❌ Erro ao criar índice: {e}")

# Criar índice de texto na coleção de vagas (opcional, para busca reversa)
vagas_collection = db["vagas"]

print("\n" + "="*60)
print("Criando índice de Full Text Search na coleção 'vagas'...")

try:
    # Verificar se já existe um índice de texto
    indexes = vagas_collection.list_indexes()
    
    for index in indexes:
        if "textIndexVersion" in index:
            print("Índice de texto já existe. Removendo para recriar...")
            vagas_collection.drop_index(index["name"])
            break
    
    # Criar índice de texto composto
    vagas_collection.create_index([
        ("titulo", TEXT),
        ("descricao", TEXT),
        ("skills", TEXT)
    ], name="vagas_text_index", default_language="portuguese")
    
    print("✅ Índice de Full Text Search criado com sucesso!")
    print("\nCampos indexados:")
    print("  - titulo (cargo da vaga)")
    print("  - descricao (descrição da vaga)")
    print("  - skills (requisitos técnicos)")
    print("\nIdioma: Português (portuguese)")
    
except Exception as e:
    print(f"❌ Erro ao criar índice: {e}")

print("\n" + "="*60)
print("Configuração concluída!")
print("\nComo funciona o matching:")
print("1. Quando uma vaga é selecionada, o sistema busca currículos usando $text")
print("2. MongoDB calcula automaticamente um score de relevância textual")
print("3. O score considera:")
print("   - Frequência dos termos (TF-IDF)")
print("   - Proximidade das palavras")
print("   - Peso dos campos indexados")
print("4. Score final = Text Score (60%) + Localização (20%) + Experiência (20%)")

client.close()
