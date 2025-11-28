"""
Script para testar a conexão com MongoDB e verificar as coleções existentes.
"""

from utils.data_io import get_database, get_collection

try:
    db = get_database()
    print("✓ Conexão com MongoDB estabelecida com sucesso!")
    print(f"  Database: {db.name}")
    print()
    
    # Listar coleções
    collections = db.list_collection_names()
    print("Coleções disponíveis:")
    for col_name in collections:
        col = get_collection(col_name)
        count = col.count_documents({})
        print(f"  - {col_name}: {count} documentos")
    
    print()
    print("Sistema pronto para uso!")
    
except Exception as e:
    print("✗ Erro ao conectar com MongoDB:")
    print(f"  {e}")
    print()
    print("Verifique se:")
    print("  1. MongoDB está rodando (net start MongoDB)")
    print("  2. A URI de conexão está correta")
    print("  3. O banco 'sistema_curriculos' existe")
