# Estrutura de Páginas do Portal de Oportunidades

## Organização por Setores

O sistema está organizado em **4 setores** através de prefixos nos nomes dos arquivos. O Streamlit exibe as páginas no menu lateral de forma organizada e sequencial:

### � Geral (Páginas Públicas)
- **1_Geral_Cadastro_de_Usuario.py** - Registro de novos usuários (candidato/empregador/admin)
- **2_Geral_Listagem_de_Vagas.py** - Visualização pública de vagas com filtros e candidatura

### � Candidato (Acesso: Candidato)
- **3_Candidato_Meus_Curriculos.py** - Lista de currículos do candidato logado
- **4_Candidato_Cadastro_de_Curriculo.py** - Formulário para criar novo currículo
- **5_Candidato_Minhas_Candidaturas.py** - Histórico de candidaturas enviadas

### � Empregador (Acesso: Empregador + Admin)
- **6_Empregador_Cadastro_de_Vaga.py** - Formulário para publicar nova vaga
- **7_Empregador_Minhas_Vagas.py** - Lista de vagas criadas pelo empregador
- **8_Empregador_Candidaturas_Recebidas.py** - Candidatos que se aplicaram às vagas

### � Admin (Acesso: Administrador)
- **9_Admin_Listagem_de_Curriculos.py** - Visualização completa de todos os currículos com filtros avançados
- **10_Admin_Gerenciar_Usuarios.py** - Gestão de usuários do sistema
- **11_Admin_Dashboard.py** - Estatísticas, métricas e mapa geográfico de vagas

## Controle de Acesso

Cada página utiliza a função `require_perfil()` para validar o acesso:

```python
from utils.ui import require_perfil

# Apenas candidatos
require_perfil(["candidato"])

# Empregadores e admins
require_perfil(["empregador", "administrador"])

# Apenas admins
require_perfil(["administrador"])
```

## Navegação

O menu lateral do Streamlit lista as páginas em ordem numérica. Os prefixos (Geral, Candidato, Empregador, Admin) ajudam a identificar visualmente a que setor cada página pertence.

## Benefícios da Nova Estrutura

✅ **Organização Visual**: Prefixos claros indicam o setor de cada página
✅ **Nomenclatura Consistente**: Padrão fácil de entender e manter
✅ **Compatibilidade Total**: Funciona nativamente com o Streamlit sem necessidade de subpastas
✅ **Ordem Lógica**: Páginas agrupadas por função através da numeração sequencial
