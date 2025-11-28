"""
Script para importar dados dos arquivos CSV para o MongoDB.
Execute este script apenas uma vez para migrar os dados existentes.
"""

import csv
import json
from pathlib import Path

from pymongo import MongoClient

# Configuração
MONGO_URI = "mongodb://localhost:27017/"
MONGO_DB_NAME = "sistema_curriculos"

def import_users():
    """Importa usuários do JSON para MongoDB."""
    print("Importando usuários...")
    users_file = Path("data/users.json")
    if not users_file.exists():
        print("  Arquivo users.json não encontrado, pulando...")
        return
    
    with users_file.open(encoding="utf-8") as f:
        users = json.load(f)
    
    if not users:
        print("  Nenhum usuário para importar")
        return
    
    client = MongoClient(MONGO_URI)
    db = client[MONGO_DB_NAME]
    collection = db["usuarios"]
    
    # Limpar coleção existente
    collection.delete_many({})
    
    # Inserir usuários
    collection.insert_many(users)
    print(f"  ✓ {len(users)} usuários importados")

def import_vagas():
    """Importa vagas do CSV para MongoDB."""
    print("Importando vagas...")
    vagas_file = Path("vagas.csv")
    if not vagas_file.exists():
        print("  Arquivo vagas.csv não encontrado, pulando...")
        return
    
    client = MongoClient(MONGO_URI)
    db = client[MONGO_DB_NAME]
    collection = db["vagas"]
    
    # Limpar coleção existente
    collection.delete_many({})
    
    with vagas_file.open(encoding="utf-8") as f:
        reader = csv.DictReader(f, delimiter=";")
        vagas = list(reader)
    
    if vagas:
        collection.insert_many(vagas)
        print(f"  ✓ {len(vagas)} vagas importadas")
    else:
        print("  Nenhuma vaga para importar")

def import_curriculos():
    """Importa currículos do CSV para MongoDB."""
    print("Importando currículos...")
    curriculos_file = Path("curriculos.csv")
    if not curriculos_file.exists():
        print("  Arquivo curriculos.csv não encontrado, pulando...")
        return
    
    client = MongoClient(MONGO_URI)
    db = client[MONGO_DB_NAME]
    collection = db["curriculos"]
    
    # Limpar coleção existente
    collection.delete_many({})
    
    with curriculos_file.open(encoding="utf-8") as f:
        reader = csv.DictReader(f, delimiter=";")
        curriculos = list(reader)
    
    if curriculos:
        # Converter id para inteiro
        for curriculo in curriculos:
            if "id" in curriculo:
                try:
                    curriculo["id"] = int(curriculo["id"])
                except (ValueError, TypeError):
                    pass
        
        collection.insert_many(curriculos)
        print(f"  ✓ {len(curriculos)} currículos importados")
    else:
        print("  Nenhum currículo para importar")

def create_indexes():
    """Cria índices úteis no MongoDB."""
    print("Criando índices...")
    client = MongoClient(MONGO_URI)
    db = client[MONGO_DB_NAME]
    
    # Índices para vagas
    db["vagas"].create_index("estado")
    db["vagas"].create_index("titulo")
    db["vagas"].create_index("empresa")
    
    # Índices para currículos
    db["curriculos"].create_index("id")
    db["curriculos"].create_index("nome")
    db["curriculos"].create_index("email")
    
    # Índice para usuários
    db["usuarios"].create_index("username")
    
    print("  ✓ Índices criados")

if __name__ == "__main__":
    print("=" * 60)
    print("IMPORTAÇÃO DE DADOS CSV PARA MONGODB")
    print("=" * 60)
    print()
    
    try:
        import_users()
        import_vagas()
        import_curriculos()
        create_indexes()
        
        print()
        print("=" * 60)
        print("✓ IMPORTAÇÃO CONCLUÍDA COM SUCESSO!")
        print("=" * 60)
        print()
        print("Próximos passos:")
        print("1. Instale o pymongo: pip install pymongo")
        print("2. Certifique-se de que o MongoDB está rodando")
        print("3. Execute o aplicativo: streamlit run app.py")
        
    except Exception as e:
        print()
        print("✗ ERRO durante a importação:")
        print(f"  {e}")
        print()
        print("Verifique se o MongoDB está rodando e acessível.")
