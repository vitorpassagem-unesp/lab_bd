"""
Script para verificar a estrutura das coleções do MongoDB.
Mostra as colunas/campos disponíveis em cada coleção.
"""

from utils.data_io import get_collection

def check_collection(name):
    """Verifica estrutura de uma coleção."""
    print(f"\n{'='*60}")
    print(f"Coleção: {name}")
    print('='*60)
    
    collection = get_collection(name)
    count = collection.count_documents({})
    print(f"Total de documentos: {count}")
    
    if count == 0:
        print("  (vazia)")
        return
    
    # Pegar um documento de exemplo
    sample = collection.find_one({})
    if sample:
        print("\nCampos disponíveis:")
        for key in sample.keys():
            if key != "_id":
                value = sample[key]
                value_type = type(value).__name__
                value_preview = str(value)[:50] if value else "(vazio)"
                print(f"  - {key}: {value_type}")
                print(f"    Exemplo: {value_preview}")

if __name__ == "__main__":
    print("VERIFICAÇÃO DA ESTRUTURA DO MONGODB")
    print("=" * 60)
    
    try:
        # Verificar cada coleção
        check_collection("usuarios")
        check_collection("vagas")
        check_collection("curriculos")
        
        print("\n" + "="*60)
        print("✓ Verificação concluída!")
        print("="*60)
        
    except Exception as e:
        print(f"\n✗ Erro: {e}")
        print("\nVerifique se o MongoDB está rodando e acessível.")
