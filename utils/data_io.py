from __future__ import annotations

import os
from typing import Any, Dict, List, Optional

from pandas import DataFrame
import pandas as pd
from pymongo import MongoClient
from pymongo.collection import Collection
from pymongo.database import Database

# Configuração do MongoDB
MONGO_URI = os.getenv("MONGO_URI", "mongodb+srv://admin:admin@labbd.tapfnsh.mongodb.net/sistema_curriculos")
MONGO_DB_NAME = os.getenv("MONGO_DB_NAME", "sistema_curriculos")

_client: Optional[MongoClient] = None
_db: Optional[Database] = None


def get_mongo_client() -> MongoClient:
    """Retorna cliente MongoDB singleton."""
    global _client
    if _client is None:
        _client = MongoClient(MONGO_URI)
    return _client


def get_database() -> Database:
    """Retorna database MongoDB."""
    global _db
    if _db is None:
        client = get_mongo_client()
        _db = client[MONGO_DB_NAME]
    return _db


def get_collection(name: str) -> Collection:
    """Retorna coleção MongoDB por nome."""
    db = get_database()
    return db[name]


# ===== USUÁRIOS =====

def load_users() -> List[Dict[str, Any]]:
    """Carrega todos os usuários do MongoDB."""
    collection = get_collection("usuarios")
    users = list(collection.find({}, {"_id": 0}))
    return users


def add_user(username: str, password: str, email: str, perfil: str = "candidato") -> None:
    """Adiciona novo usuário ao MongoDB com perfil."""
    collection = get_collection("usuarios")
    existing = collection.find_one({"username": {"$regex": f"^{username}$", "$options": "i"}})
    if existing:
        raise ValueError("Usuário já cadastrado.")
    collection.insert_one({
        "username": username, 
        "password": password, 
        "email": email,
        "perfil": perfil  # candidato, empregador, administrador
    })


def validate_credentials(username: str, password: str) -> Optional[Dict[str, Any]]:
    """Valida credenciais de usuário no MongoDB e retorna dados do usuário."""
    collection = get_collection("usuarios")
    user = collection.find_one({
        "username": {"$regex": f"^{username}$", "$options": "i"},
        "password": password
    }, {"_id": 0})
    return user


def get_user_by_username(username: str) -> Optional[Dict[str, Any]]:
    """Busca usuário pelo username."""
    collection = get_collection("usuarios")
    return collection.find_one(
        {"username": {"$regex": f"^{username}$", "$options": "i"}},
        {"_id": 0}
    )


# ===== VAGAS =====

def load_vagas(filtro: Optional[Dict[str, Any]] = None) -> DataFrame:
    """Carrega vagas do MongoDB como DataFrame com filtro opcional."""
    collection = get_collection("vagas")
    query = filtro if filtro else {}
    vagas = list(collection.find(query, {"_id": 0}))
    return pd.DataFrame(vagas)


def load_vagas_by_empregador(username: str) -> DataFrame:
    """Carrega vagas de um empregador específico."""
    return load_vagas({"criado_por": username})


def add_vaga(data: Dict[str, Any]) -> None:
    """Adiciona nova vaga ao MongoDB."""
    collection = get_collection("vagas")
    collection.insert_one(data)


def get_vaga_by_id(vaga_id: str) -> Optional[Dict[str, Any]]:
    """Busca vaga por ID."""
    collection = get_collection("vagas")
    return collection.find_one({"id": vaga_id}, {"_id": 0})


# ===== CURRÍCULOS =====

def load_curriculos(filtro: Optional[Dict[str, Any]] = None) -> DataFrame:
    """Carrega currículos do MongoDB como DataFrame com filtro opcional."""
    collection = get_collection("curriculos")
    query = filtro if filtro else {}
    curriculos = list(collection.find(query, {"_id": 0}))
    return pd.DataFrame(curriculos)


def load_curriculos_by_candidato(username: str) -> DataFrame:
    """Carrega currículos de um candidato específico."""
    return load_curriculos({"criado_por": username})


def add_curriculo(data: Dict[str, Any]) -> None:
    """Adiciona novo currículo ao MongoDB."""
    collection = get_collection("curriculos")
    collection.insert_one(data)


def get_curriculo_by_id(curriculo_id: int) -> Optional[Dict[str, Any]]:
    """Busca currículo por ID."""
    collection = get_collection("curriculos")
    return collection.find_one({"id": curriculo_id}, {"_id": 0})


# ===== CANDIDATURAS =====

def load_candidaturas(filtro: Optional[Dict[str, Any]] = None) -> List[Dict[str, Any]]:
    """Carrega candidaturas do MongoDB."""
    collection = get_collection("candidaturas")
    query = filtro if filtro else {}
    return list(collection.find(query, {"_id": 0}))


def add_candidatura(vaga_id: str, candidato_username: str, curriculo_id: int) -> None:
    """Registra candidatura de um candidato a uma vaga."""
    collection = get_collection("candidaturas")
    # Verificar se já aplicou
    existing = collection.find_one({
        "vaga_id": vaga_id,
        "candidato_username": candidato_username
    })
    if existing:
        raise ValueError("Você já se candidatou a esta vaga.")
    
    from datetime import datetime
    collection.insert_one({
        "vaga_id": vaga_id,
        "candidato_username": candidato_username,
        "curriculo_id": curriculo_id,
        "data_candidatura": datetime.now().isoformat(),
        "status": "pendente"
    })


def check_candidatura_exists(vaga_id: str, candidato_username: str) -> bool:
    """Verifica se candidato já aplicou para a vaga."""
    collection = get_collection("candidaturas")
    return collection.find_one({
        "vaga_id": vaga_id,
        "candidato_username": candidato_username
    }) is not None


def calcular_score_curriculo(curriculo: Dict[str, Any], vaga: Dict[str, Any]) -> float:
    """
    Calcula score de compatibilidade entre currículo e vaga usando Full Text Search do MongoDB.
    
    O score é calculado automaticamente pelo MongoDB através de:
    1. Text Search Score (60%): MongoDB calcula similaridade textual entre skills, 
       formação e experiência do currículo vs. descrição e skills da vaga
    2. Localização (20%): Match exato de estado/cidade
    3. Experiência (20%): Anos de experiência do candidato
    
    Args:
        curriculo: Dicionário com dados do currículo
        vaga: Dicionário com dados da vaga
        
    Returns:
        Score de 0 a 100 representando compatibilidade
    """
    score = 0.0
    
    try:
        # 1. Full Text Search Score (60%) - Usa índice de texto do MongoDB
        collection = get_collection("curriculos")
        
        # Criar query de busca textual com base nos requisitos da vaga
        search_terms = []
        if vaga.get("skills"):
            search_terms.append(str(vaga.get("skills")))
        if vaga.get("descricao"):
            search_terms.append(str(vaga.get("descricao")))
        
        search_query = " ".join(search_terms)
        
        if search_query and curriculo.get("_id"):
            # Buscar o currículo específico com text search score
            result = collection.find_one(
                {
                    "_id": curriculo.get("_id"),
                    "$text": {"$search": search_query}
                },
                {"score": {"$meta": "textScore"}}
            )
            
            if result and "score" in result:
                # Normalizar o score do MongoDB (geralmente 0.5-1.5) para 0-60
                text_score = min(result["score"] / 1.5, 1.0) * 60
                score += text_score
            else:
                # Fallback: comparação simples de skills se não houver índice de texto
                curriculo_skills = set([s.strip().lower() for s in str(curriculo.get("skills", "")).split(",")])
                vaga_skills = set([s.strip().lower() for s in str(vaga.get("skills", "")).split(",")])
                
                if vaga_skills:
                    skills_match = len(curriculo_skills & vaga_skills) / len(vaga_skills)
                    score += skills_match * 60
        
        # 2. Localização (peso 20%)
        if curriculo.get("estado") == vaga.get("estado"):
            score += 20
        elif curriculo.get("cidade") == vaga.get("cidade"):
            score += 10
        
        # 3. Experiência (peso 20%)
        experiencia_str = str(curriculo.get("experiencia", "0"))
        import re
        match = re.search(r"(\d+)", experiencia_str)
        if match:
            anos_exp = int(match.group(1))
            if anos_exp >= 5:
                score += 20
            elif anos_exp >= 3:
                score += 15
            elif anos_exp >= 1:
                score += 10
    
    except Exception as e:
        # Em caso de erro, usar método de fallback
        print(f"Erro ao calcular score com Full Text Search: {e}")
        
        # Fallback: comparação simples
        if "skills" in curriculo and "skills" in vaga:
            curriculo_skills = set([s.strip().lower() for s in str(curriculo.get("skills", "")).split(",")])
            vaga_skills = set([s.strip().lower() for s in str(vaga.get("skills", "")).split(",")])
            
            if vaga_skills:
                skills_match = len(curriculo_skills & vaga_skills) / len(vaga_skills)
                score += skills_match * 60
        
        if curriculo.get("estado") == vaga.get("estado"):
            score += 20
    
    return round(score, 2)
