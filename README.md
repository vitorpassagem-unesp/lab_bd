# Portal de Oportunidades - MongoDB

Sistema de gestão de vagas e currículos usando Streamlit e MongoDB.

## Requisitos

- Python 3.8+
- MongoDB 4.4+ (local ou remoto)
- Bibliotecas Python (veja requirements.txt)

## Configuração Inicial

### 1. Instalar MongoDB

**Windows:**
```bash
# Baixe e instale MongoDB Community Server de:
# https://www.mongodb.com/try/download/community

# Inicie o serviço MongoDB
net start MongoDB
```

**Linux/Mac:**
```bash
# Ubuntu/Debian
sudo apt-get install mongodb

# Mac (usando Homebrew)
brew install mongodb-community
brew services start mongodb-community
```

### 2. Instalar Dependências Python

```bash
pip install streamlit pandas pymongo
```

Ou use o arquivo requirements.txt:
```bash
pip install -r requirements.txt
```

### 3. Configurar MongoDB (Opcional)

Se quiser configurar usuário e índices personalizados, edite e execute:

```bash
mongosh < setup_mongo.js
```

### 4. **Configurar Índices de Full Text Search (IMPORTANTE)**

O sistema utiliza Full Text Search do MongoDB para matching automático entre currículos e vagas. Execute:

```bash
python create_text_index.py
```

Este script cria índices de texto otimizados nas coleções de currículos e vagas, permitindo:
- Busca inteligente com TF-IDF
- Score automático de compatibilidade
- Suporte a idioma português (stemming e stop words)

**📖 Para detalhes sobre o algoritmo de matching, consulte [SISTEMA_MATCHING.md](SISTEMA_MATCHING.md)**

### 5. Importar Dados CSV para MongoDB

Execute o script de importação para migrar os dados existentes:

```bash
python import_csv_to_mongo.py
```

### 6. Configurar Variáveis de Ambiente (Opcional)

Por padrão, a aplicação conecta em `mongodb://localhost:27017/` com database `sistema_curriculos`.

Para customizar, crie um arquivo `.env`:

```env
MONGO_URI=mongodb://localhost:27017/
MONGO_DB_NAME=sistema_curriculos
```

## Executar a Aplicação

```bash
streamlit run app.py
```

A aplicação estará disponível em `http://localhost:8501`

## Estrutura do Banco de Dados

### Collections

- **usuarios**: Usuários do sistema com login e senha
- **vagas**: Vagas abertas cadastradas
- **curriculos**: Currículos de candidatos

### Campos das Vagas

- titulo
- descricao
- cidade
- estado
- tipo_contratacao (CLT, PJ, Estágio, Temporário)
- salario
- empresa
- skills

### Campos dos Currículos

- id
- nome
- email
- telefone
- formacao
- experiencia
- skills
- idiomas
- certificacoes
- resumo
- empresas_previas
- ids_contatos

## Funcionalidades

### 🔐 Autenticação e Perfis
- **3 tipos de usuário**: Candidato, Empregador, Administrador
- Sistema de login com controle de acesso por perfil

### 📋 Gestão de Vagas
- Listagem pública com filtros (estado, tipo, empresa, skills)
- Cadastro de vagas (empregadores)
- Visualização de vagas por empregador

### 📄 Gestão de Currículos
- Cadastro completo de currículos (candidatos)
- Listagem de currículos próprios
- Filtros avançados (idiomas, certificações, experiência, skills)

### ⭐ Matching Automático (DESTAQUE)
**Sistema de pontuação automática usando MongoDB Full Text Search**

O sistema calcula automaticamente um **score de compatibilidade de 0 a 100** entre currículos e vagas:

- **60%**: Text Search Score do MongoDB (TF-IDF)
  - Analisa skills, formação, experiência e descrição
  - Calcula relevância automática dos termos
  - Suporte a português (stemming)

- **20%**: Localização geográfica
  - Match de estado/cidade

- **20%**: Anos de experiência
  - Graduação por faixa de experiência

**Como funciona:**
1. Empregador seleciona uma vaga
2. MongoDB busca currículos usando `$text` search
3. Sistema calcula score composto automaticamente
4. Exibe ranking dos 10 melhores currículos

**Documentação completa:** [SISTEMA_MATCHING.md](SISTEMA_MATCHING.md)

### 📊 Dashboard Administrativo
- Estatísticas gerais do sistema
- Distribuição geográfica de vagas
- Top empresas e skills mais demandadas
- Mapa interativo com concentração de vagas

## Solução de Problemas

### Erro de conexão com MongoDB

Verifique se o MongoDB está rodando:
```bash
# Windows
net start MongoDB

# Linux/Mac
sudo systemctl status mongodb
# ou
brew services list
```

### Import "pymongo" could not be resolved

Instale o pymongo:
```bash
pip install pymongo
```

### Dados não aparecem

Execute o script de importação novamente:
```bash
python import_csv_to_mongo.py
```

## Desenvolvimento

### Estrutura do Projeto

```
lab_bd/
├── app.py                                    # Página principal (login)
├── pages/
│   ├── 1_Geral_-_Cadastro_de_Usuario.py     # Registro público
│   ├── 2_Geral_-_Listagem_de_Vagas.py       # Vagas + Matching
│   ├── 3_Candidato_-_Meus_Curriculos.py     # Currículos do candidato
│   ├── 4_Candidato_-_Cadastro_de_Curriculo.py
│   ├── 6_Empregador_-_Cadastro_de_Vaga.py
│   ├── 7_Empregador_-_Minhas_Vagas.py
│   ├── 9_Admin_-_Listagem_de_Curriculos.py  # Todos os currículos
│   ├── 10_Admin_-_Gerenciar_Usuarios.py
│   └── 11_Admin_-_Dashboard.py              # Estatísticas
├── utils/
│   ├── data_io.py                           # MongoDB + Algoritmo de Matching
│   └── ui.py                                # Controle de acesso
├── create_text_index.py                     # Script de configuração FTS
├── import_csv_to_mongo.py                   # Importação de dados
├── SISTEMA_MATCHING.md                      # 📖 Documentação do Matching
├── ESTRUTURA_PAGINAS.md                     # Organização das páginas
└── README.md                                # Este arquivo
```

### Tecnologias

- **Backend**: Python 3.8+, PyMongo
- **Frontend**: Streamlit
- **Banco de Dados**: MongoDB 4.4+ com Full Text Search
- **Matching**: TF-IDF (Term Frequency-Inverse Document Frequency)

## Próximos Passos

- [x] ✅ Implementar Full Text Search no MongoDB
- [x] ✅ Sistema de matching automático com score
- [x] ✅ Dashboard com estatísticas e mapa
- [x] ✅ Controle de acesso por perfil
- [ ] Adicionar hash de senhas (bcrypt)
- [ ] Paginação nas listagens
- [ ] Exportar relatórios para CSV/Excel
- [ ] Sinônimos no text search (JS → JavaScript)
- [ ] Machine Learning para ajuste de pesos
