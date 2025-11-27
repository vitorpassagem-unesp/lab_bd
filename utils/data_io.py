from __future__ import annotations

import csv
import json
from pathlib import Path
from typing import Dict, Iterable, List

from pandas import DataFrame
import pandas as pd

DATA_DIR = Path(__file__).resolve().parent.parent / "data"
USERS_FILE = DATA_DIR / "users.json"


def load_users() -> List[Dict[str, str]]:
    if not USERS_FILE.exists():
        USERS_FILE.write_text("[]", encoding="utf-8")
    return json.loads(USERS_FILE.read_text(encoding="utf-8"))


def save_users(users: Iterable[Dict[str, str]]) -> None:
    USERS_FILE.write_text(json.dumps(list(users), indent=2), encoding="utf-8")


def add_user(username: str, password: str, email: str) -> None:
    users = load_users()
    if any(user["username"].lower() == username.lower() for user in users):
        raise ValueError("Usuário já cadastrado.")
    users.append({"username": username, "password": password, "email": email})
    save_users(users)


def validate_credentials(username: str, password: str) -> bool:
    users = load_users()
    return any(user["username"].lower() == username.lower() and user["password"] == password for user in users)


def _get_csv_path(filename: str) -> Path:
    return Path(__file__).resolve().parent.parent / filename


def load_csv_as_dataframe(filename: str, delimiter: str = ";") -> DataFrame:
    csv_path = _get_csv_path(filename)
    return pd.read_csv(csv_path, delimiter=delimiter)


def get_csv_headers(filename: str, delimiter: str = ";") -> List[str]:
    csv_path = _get_csv_path(filename)
    with csv_path.open(newline="", encoding="utf-8") as handle:
        reader = csv.reader(handle, delimiter=delimiter)
        try:
            return next(reader)
        except StopIteration:
            raise ValueError("Arquivo CSV sem cabeçalho.")


def append_dict_to_csv(filename: str, data: Dict[str, str], delimiter: str = ";") -> None:
    headers = get_csv_headers(filename, delimiter=delimiter)
    csv_path = _get_csv_path(filename)
    row = {field: data.get(field, "") for field in headers}
    with csv_path.open("a", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=headers, delimiter=delimiter)
        writer.writerow(row)
