

> **Trabalho para a disciplina de Laboratório de Banco de Dados, UNESP Rio Claro, 2025.**  
> **Alunos: Vitor Passagem e Pedro Bastos**
Deploy de produção: [Streamlit Cloud](https://sistema-curriculos.streamlit.app/)

# Portal de Oportunidades - Documentação Completa

Um sistema de gestão de vagas e currículos com busca inteligente (RAG), controle de acesso por perfil, e integração com MongoDB Atlas e Google Gemini (Generative AI).

## Usuários de Teste

Estes usuários podem ser utilizados para acessar o sistema em diferentes perfis:

| Login      | Senha      | Perfil         |
|------------|------------|---------------|
| admin      | admin      | Administrador  |
| candidato  | candidato  | Candidato      |
| empregador | empregador | Empregador     |

---

## Sumário

- [Visão Geral](#visão-geral)
- [Infraestrutura e Tecnologias](#infraestrutura-e-tecnologias)
- [Funcionalidades e Mapeamento de Código](#funcionalidades-e-mapeamento-de-código)
- [Permissões e Perfis de Usuário](#permissões-e-perfis-de-usuário)
- [Sistema de Busca Inteligente (RAG)](#sistema-de-busca-inteligente-rag)
- [Configuração e Deploy](#configuração-e-deploy)
- [Estrutura do Projeto](#estrutura-do-projeto)
- [Solução de Problemas](#solução-de-problemas)
- [Próximos Passos](#próximos-passos)

---

## Visão Geral

Este portal permite:

- Cadastro e autenticação de usuários (candidato, empregador, administrador)
- Cadastro e listagem de vagas e currículos
- Busca inteligente (RAG) por vagas e currículos usando Google Gemini e MongoDB Atlas
- Matching automático entre vagas e currículos com score
- Dashboard administrativo com estatísticas e mapas
- Controle de acesso robusto por perfil

---

## Infraestrutura e Tecnologias

### Principais Componentes

- **Frontend:** [Streamlit](https://streamlit.io/) (UI, navegação, autenticação)
- **Backend:** Python 3.8+, [PyMongo](https://pymongo.readthedocs.io/) (acesso ao MongoDB)
- **Banco de Dados:** [MongoDB Atlas](https://www.mongodb.com/atlas) (coleções: `usuarios`, `vagas`, `curriculos`, `empresas`)
- **Busca Inteligente (RAG):** [Google Generative AI (Gemini)](https://ai.google.dev/) + MongoDB Atlas Vector Search
- **Outros:** Pandas, Protobuf

### Dependências

Veja `requirements.txt` para a lista completa:

```
streamlit>=1.30.0
pandas>=2.0.0
pymongo>=4.6.0
google-generativeai>=0.3.0
protobuf>=4.25.0
```

---

## Funcionalidades e Mapeamento de Código

### 1. Autenticação e Controle de Acesso

- **Cadastro/Login:**
  - `app.py` (login, menu dinâmico por perfil)
  - `pages/1_Geral_-_Cadastro_de_Usuario.py` (cadastro de usuário)
  - Funções: `validate_credentials`, `add_user` em `utils/data_io.py`
- **Controle de Permissões:**
  - Funções: `require_perfil`, `require_authentication` em `utils/ui.py`

### 2. Gestão de Vagas

- **Listagem Pública e Filtros:**
  - `pages/2_Geral_-_Listagem_de_Vagas.py` (filtros, dataframe, busca RAG)
  - Função: `load_vagas` em `utils/data_io.py`
- **Cadastro de Vagas:**
  - `pages/6_Empregador_-_Cadastro_de_Vaga.py`
  - Função: `add_vaga` em `utils/data_io.py`
- **Minhas Vagas (Empregador):**
  - `pages/7_Empregador_-_Minhas_Vagas.py` (ranking de currículos)
  - Função: `load_vagas_by_empregador`

### 3. Gestão de Currículos

- **Cadastro de Currículo:**
  - `pages/4_Candidato_-_Cadastro_de_Curriculo.py`
  - Função: `add_curriculo` em `utils/data_io.py`
- **Meus Currículos (Candidato):**
  - `pages/3_Candidato_-_Meus_Curriculos.py`
  - Função: `load_curriculos_by_candidato`
- **Listagem de Currículos (Admin/Empregador):**
  - `pages/9_Empregador_-_Listagem_de_Curriculos.py`
  - Função: `load_curriculos`

### 4. Matching Automático (Score de Compatibilidade)

- **Ranking de Currículos para Vaga:**
  - `pages/7_Empregador_-_Minhas_Vagas.py` (ranking por score)
  - Função: `calcular_score_curriculo` em `utils/data_io.py`
  - Algoritmo: Combina Full Text Search, localização e experiência

### 5. Busca Inteligente (RAG)

- **Busca Natural em Vagas:**
  - `pages/2_Geral_-_Listagem_de_Vagas.py` (seção "Busca Natural em Vagas (RAG)")
  - Usa Google Gemini para embedding + MongoDB Atlas Vector Search
- **Busca Natural em Currículos:**
  - `pages/9_Empregador_-_Listagem_de_Curriculos.py` (seção "Busca Natural em Currículos (RAG)")
  - Usa Google Gemini para embedding + MongoDB Atlas Vector Search

### 6. Dashboard e Administração

- **Dashboard Estatístico:**
  - `pages/11_Admin_-_Dashboard.py` (métricas, gráficos, mapas)
- **Gerenciamento de Usuários:**
  - `pages/10_Admin_-_Gerenciar_Usuarios.py`

---

## Permissões e Perfis de Usuário

O sistema implementa controle de acesso robusto:

- **Candidato:**
  - Cadastra e visualiza currículos próprios
  - Visualiza vagas
- **Empregador:**
  - Cadastra vagas, visualiza suas vagas
  - Visualiza currículos (com filtros e ranking)
- **Administrador:**
  - Acesso total: gerencia usuários, dashboard, todas as vagas/currículos

Controle implementado via `require_perfil` e checagem de sessão em cada página.

---

## Sistema de Busca Inteligente (RAG)

### Como Funciona

1. Usuário digita uma pergunta (ex: "Quais vagas para Python remoto?")
2. Gemini gera embedding da pergunta
3. MongoDB Atlas Vector Search retorna documentos mais próximos
4. Gemini gera resposta textual baseada apenas no contexto retornado

### Implementação

- **Vagas:**
  - Funções: `gerarEmbeddingsPerguntas_vagas`, `getDocsMongodbAtlas_vagas`, `gerarPrompt_vagas` em `pages/2_Geral_-_Listagem_de_Vagas.py`
- **Currículos:**
  - Funções: `gerarEmbeddingsPerguntas_curriculos`, `getDocsMongodbAtlas_curriculos`, `gerarPrompt_curriculos` em `pages/9_Empregador_-_Listagem_de_Curriculos.py`

### Observações

- O contexto enviado ao Gemini é limitado para evitar vazamento de dados
- O modelo só responde com base no contexto retornado do banco

---

## Configuração e Deploy

### 1. Pré-requisitos

- Python 3.8+
- Conta no [MongoDB Atlas](https://www.mongodb.com/atlas) (ou MongoDB local)
- Chave de API do Google Gemini

### 2. Instalação

```bash
pip install -r requirements.txt
```

### 3. Configuração do Banco

Por padrão, conecta em `mongodb+srv://admin:admin@labbd.tapfnsh.mongodb.net/sistema_curriculos`.
Para customizar, defina as variáveis de ambiente:

```
MONGO_URI=<sua_uri>
MONGO_DB_NAME=sistema_curriculos
```

### 4. Executando Localmente

```bash
streamlit run app.py
```

### 5. Deploy em Produção

- Utilizado: [Streamlit Cloud](https://streamlit.io/cloud)

---


## Estrutura de Páginas e Controle de Acesso

O sistema está organizado em setores, com prefixos numéricos e nomes descritivos para facilitar a navegação e o controle de acesso. Cada página utiliza a função `require_perfil()` para garantir que apenas usuários autorizados possam acessá-la.

### Organização Atual das Páginas

#### Geral (Público)
- **1_Geral_-_Cadastro_de_Usuario.py** — Registro de novos usuários (candidato, empregador, admin)
- **2_Geral_-_Listagem_de_Vagas.py** — Visualização pública de vagas com filtros e busca inteligente (RAG)

#### Candidato (Acesso: Candidato)
- **3_Candidato_-_Meus_Curriculos.py** — Lista de currículos do candidato logado
- **4_Candidato_-_Cadastro_de_Curriculo.py** — Formulário para criar novo currículo

#### Empregador (Acesso: Empregador, Administrador)
- **6_Empregador_-_Cadastro_de_Vaga.py** — Formulário para publicar nova vaga
- **7_Empregador_-_Minhas_Vagas.py** — Lista de vagas criadas pelo empregador, ranking de currículos

#### Admin (Acesso: Administrador)
- **9_Empregador_-_Listagem_de_Curriculos.py** — Visualização completa de todos os currículos com filtros avançados e busca RAG
- **10_Admin_-_Gerenciar_Usuarios.py** — Gestão de usuários do sistema
- **11_Admin_-_Dashboard.py** — Estatísticas, métricas e mapa geográfico de vagas

> **Nota:** As páginas são exibidas no menu lateral do Streamlit em ordem numérica, agrupadas por setor. O controle de acesso é feito por `require_perfil(["perfil"])` no início de cada página.

---

## Estrutura do Projeto

```
lab_bd/
├── app.py                        # Página principal (login, menu)
├── pages/
│   ├── 1_Geral_-_Cadastro_de_Usuario.py
│   ├── 2_Geral_-_Listagem_de_Vagas.py
│   ├── 3_Candidato_-_Meus_Curriculos.py
│   ├── 4_Candidato_-_Cadastro_de_Curriculo.py
│   ├── 6_Empregador_-_Cadastro_de_Vaga.py
│   ├── 7_Empregador_-_Minhas_Vagas.py
│   ├── 9_Empregador_-_Listagem_de_Curriculos.py
│   ├── 10_Admin_-_Gerenciar_Usuarios.py
│   └── 11_Admin_-_Dashboard.py
├── utils/
│   ├── data_io.py                 # Funções de acesso a dados e matching
│   └── ui.py                      # Controle de sessão e permissões
├── requirements.txt
├── README.md
└── ...
```
