# Sistema de Matching Automático - Portal de Oportunidades

## Visão Geral

O Portal de Oportunidades utiliza **Full Text Search do MongoDB** para realizar o matching automático entre currículos e vagas. O sistema calcula um **score de compatibilidade de 0 a 100** para cada combinação currículo-vaga.

## Tecnologia: MongoDB Full Text Search

### Por que Full Text Search?

O MongoDB Full Text Search oferece:
- **Busca textual inteligente**: Análise semântica de texto em linguagem natural
- **TF-IDF (Term Frequency-Inverse Document Frequency)**: Pontuação automática baseada em relevância
- **Suporte a Português**: Stemming e stop words para idioma português
- **Performance**: Índices otimizados para buscas rápidas em grandes volumes

### Índices Criados

```javascript
// Coleção: curriculos
db.curriculos.createIndex(
  {
    skills: "text",
    formacao: "text",
    experiencia: "text",
    resumo: "text",
    certificacoes: "text"
  },
  {
    name: "curriculos_text_index",
    default_language: "portuguese"
  }
)

// Coleção: vagas
db.vagas.createIndex(
  {
    titulo: "text",
    descricao: "text",
    skills: "text"
  },
  {
    name: "vagas_text_index",
    default_language: "portuguese"
  }
)
```

## Algoritmo de Scoring

### Composição do Score (0-100)

O score final é composto por três componentes:

#### 1. Text Search Score (60%)

**Como funciona:**
```python
# Query MongoDB com $text search
result = collection.find_one(
    {
        "_id": curriculo_id,
        "$text": {"$search": "python javascript react nodejs"}
    },
    {"score": {"$meta": "textScore"}}
)

# MongoDB retorna score baseado em:
# - Frequência dos termos (TF-IDF)
# - Proximidade das palavras
# - Peso dos campos indexados
```

**Cálculo:**
- MongoDB gera um score de relevância (tipicamente 0.5 a 1.5)
- Normalizamos para 0-60: `(mongodb_score / 1.5) * 60`
- Quanto mais termos da vaga aparecem no currículo, maior o score

**Exemplo:**
```
Vaga: "Desenvolvedor Python com experiência em Django e PostgreSQL"
Currículo A: skills = "Python, Django, PostgreSQL, Docker"
Currículo B: skills = "Java, Spring Boot, MySQL"

MongoDB Score A: 1.2 → Normalizado: 48/60
MongoDB Score B: 0.0 → Normalizado: 0/60
```

#### 2. Localização (20%)

**Critérios:**
- Match de estado: +20 pontos
- OU match de cidade (mais específico): +10 pontos

**Exemplo:**
```
Vaga: São Paulo, SP
Currículo A: São Paulo, SP → +20 pontos
Currículo B: Campinas, SP → +20 pontos (mesmo estado)
Currículo C: Rio de Janeiro, RJ → +0 pontos
```

#### 3. Experiência (20%)

**Critérios baseados em anos de experiência:**
- 5+ anos: +20 pontos
- 3-4 anos: +15 pontos
- 1-2 anos: +10 pontos
- Menos de 1 ano: +0 pontos

**Extração:**
```python
# Regex extrai número de "5 anos como desenvolvedor"
experiencia = "5 anos como desenvolvedor Python"
anos = 5 → +20 pontos
```

## Fluxo de Matching

### 1. Empregador Seleciona Vaga
```
[Empregador] → Seleciona vaga → [Sistema]
```

### 2. Sistema Executa Query
```python
# Construir query de busca
search_terms = vaga.skills + " " + vaga.descricao

# Buscar todos os currículos com text search
curriculos = db.curriculos.find(
    {"$text": {"$search": search_terms}},
    {"score": {"$meta": "textScore"}}
).sort([("score", {"$meta": "textScore"})])
```

### 3. Cálculo de Score
```python
for curriculo in curriculos:
    score = 0
    
    # 60%: Text Search (MongoDB)
    score += (curriculo['mongodb_score'] / 1.5) * 60
    
    # 20%: Localização
    if curriculo.estado == vaga.estado:
        score += 20
    
    # 20%: Experiência
    if anos_experiencia >= 5:
        score += 20
    
    curriculo['score_final'] = round(score, 2)
```

### 4. Ordenação e Exibição
```python
# Ordenar por score decrescente
curriculos_ranqueados = sorted(
    curriculos, 
    key=lambda x: x['score_final'], 
    reverse=True
)

# Mostrar top 10
return curriculos_ranqueados[:10]
```

## Configuração

### 1. Criar Índices

Execute o script de configuração:
```bash
python create_text_index.py
```

### 2. Verificar Índices

No MongoDB Shell:
```javascript
// Verificar índices de currículos
db.curriculos.getIndexes()

// Verificar índices de vagas
db.vagas.getIndexes()
```

### 3. Testar Busca

```javascript
// Teste manual de busca textual
db.curriculos.find(
  { $text: { $search: "python django" } },
  { score: { $meta: "textScore" } }
).sort({ score: { $meta: "textScore" } })
```

## Exemplo Completo

### Dados de Entrada

**Vaga:**
```json
{
  "titulo": "Desenvolvedor Full Stack",
  "descricao": "Buscamos desenvolvedor com experiência em Python, Django, React e PostgreSQL",
  "skills": "Python, Django, React, PostgreSQL, Docker",
  "estado": "SP",
  "cidade": "São Paulo"
}
```

**Currículo:**
```json
{
  "nome": "João Silva",
  "skills": "Python, Django, Flask, PostgreSQL, Git",
  "formacao": "Ciência da Computação - USP",
  "experiencia": "5 anos como desenvolvedor backend",
  "resumo": "Desenvolvedor Python especializado em Django e APIs REST",
  "estado": "SP",
  "cidade": "São Paulo"
}
```

### Cálculo do Score

1. **Text Search (60%)**
   - Termos encontrados: Python (2x), Django (2x), PostgreSQL (2x)
   - MongoDB Score: 1.3
   - Normalizado: (1.3 / 1.5) × 60 = **52 pontos**

2. **Localização (20%)**
   - Estado SP = SP ✓
   - Cidade São Paulo = São Paulo ✓
   - Score: **20 pontos**

3. **Experiência (20%)**
   - 5 anos de experiência
   - Score: **20 pontos**

**Score Final: 52 + 20 + 20 = 92/100** ⭐

## Vantagens da Abordagem

✅ **Automático**: Não requer configuração manual de pesos  
✅ **Escalável**: MongoDB otimizado para grandes volumes  
✅ **Inteligente**: TF-IDF considera relevância contextual  
✅ **Multilíngue**: Suporte nativo a português (stemming)  
✅ **Performático**: Índices de texto são muito eficientes  
✅ **Flexível**: Fácil adicionar novos campos ao índice  

## Melhorias Futuras

- [ ] Adicionar sinônimos (ex: "JS" → "JavaScript")
- [ ] Peso dinâmico por campo (skills > experiência > resumo)
- [ ] Machine Learning para ajuste fino de pesos
- [ ] Análise de sentimento em descrições
- [ ] Filtros por salário e tipo de contratação

## Referências

- [MongoDB Text Search Documentation](https://docs.mongodb.com/manual/text-search/)
- [MongoDB Text Indexes](https://docs.mongodb.com/manual/core/index-text/)
- [TF-IDF Algorithm](https://en.wikipedia.org/wiki/Tf%E2%80%93idf)
