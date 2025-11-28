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

### 4. Importar Dados CSV para MongoDB

Execute o script de importação para migrar os dados existentes:

```bash
python import_csv_to_mongo.py
```

### 5. Configurar Variáveis de Ambiente (Opcional)

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

1. **Login/Cadastro de Usuários**
   - Sistema de autenticação simples
   - Cadastro de novos usuários

2. **Gestão de Vagas**
   - Listagem com filtros (estado, tipo, empresa, skills)
   - Cadastro de novas vagas

3. **Gestão de Currículos**
   - Listagem com filtros (idiomas, certificações, experiência, skills)
   - Cadastro de currículos com seleção de contatos

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
├── app.py                      # Página principal (login)
├── pages/
│   ├── 1_Cadastro_de_Usuario.py
│   ├── 2_Listagem_de_Vagas.py
│   ├── 3_Cadastro_de_Vaga.py
│   ├── 4_Listagem_de_Curriculos.py
│   └── 5_Cadastro_de_Curriculo.py
├── utils/
│   ├── data_io.py             # Funções de acesso ao MongoDB
│   └── ui.py                  # Utilitários de interface
├── data/
│   └── users.json             # Backup de usuários (legacy)
├── import_csv_to_mongo.py     # Script de importação
└── README.md                  # Este arquivo
```

## Próximos Passos

- [ ] Adicionar hash de senhas (bcrypt)
- [ ] Implementar busca full-text no MongoDB
- [ ] Adicionar paginação nas listagens
- [ ] Exportar dados para CSV/Excel
- [ ] Dashboard com estatísticas
