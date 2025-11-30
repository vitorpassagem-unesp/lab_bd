import streamlit as st

from utils.data_io import load_vagas_by_empregador
from utils.ui import require_perfil

st.set_page_config(page_title="Minhas Vagas", page_icon="📋", layout="wide")

require_perfil(["empregador", "administrador"])

st.title("Minhas Vagas")
st.page_link("app.py", label="Voltar para a página inicial", icon="🏠")

minhas_vagas = load_vagas_by_empregador(st.session_state.username)

if minhas_vagas.empty:
    st.info("Você ainda não cadastrou nenhuma vaga.")
    st.page_link("pages/6_Empregador_-_Cadastro_de_Vaga.py", label="Cadastrar nova vaga", icon="➕")
else:
    st.success(f"Total de vagas cadastradas: {len(minhas_vagas)}")
    st.dataframe(minhas_vagas, width="stretch")
    st.divider()
    st.subheader("🔎 Ver melhores currículos para cada vaga")
    import pandas as pd
    from utils.data_io import load_curriculos, calcular_score_curriculo
    if "id" in minhas_vagas.columns:
        vaga_ids = minhas_vagas["id"].tolist()
        vaga_selecionada_id = st.selectbox(
            "Selecione uma vaga para ver os melhores matchs",
            vaga_ids,
            format_func=lambda x: f"{minhas_vagas[minhas_vagas['id'] == x]['titulo'].iloc[0]} - {x}" if "titulo" in minhas_vagas.columns else x
        )
        if vaga_selecionada_id:
            vaga = minhas_vagas[minhas_vagas["id"] == vaga_selecionada_id].iloc[0].to_dict()
            st.markdown(f"### {vaga.get('titulo', 'Sem título')}")
            st.markdown(f"**Empresa:** {vaga.get('empresa', 'N/A')}")
            st.markdown(f"**Localização:** {vaga.get('cidade', 'N/A')}, {vaga.get('estado', 'N/A')}")
            st.markdown(f"**Tipo:** {vaga.get('tipo_contratacao', 'N/A')}")
            st.markdown(f"**Descrição:** {vaga.get('descricao', 'N/A')}")
            st.markdown(f"**Skills requeridas:** {vaga.get('skills', 'N/A')}")
            st.divider()
            st.subheader("📊 Melhores Currículos para esta Vaga")
            todos_curriculos = load_curriculos()
            if not todos_curriculos.empty:
                curriculos_com_score = []
                for _, curriculo in todos_curriculos.iterrows():
                    score = calcular_score_curriculo(curriculo.to_dict(), vaga)
                    curriculos_com_score.append({
                        **curriculo.to_dict(),
                        "score_compatibilidade": score
                    })
                curriculos_ranking = pd.DataFrame(curriculos_com_score)
                curriculos_ranking = curriculos_ranking.sort_values("score_compatibilidade", ascending=False)
                st.dataframe(
                    curriculos_ranking.head(10),
                    width="stretch",
                    column_config={
                        "score_compatibilidade": st.column_config.NumberColumn(
                            "Score %",
                            help="Score de compatibilidade com a vaga",
                            format="%.1f%%"
                        )
                    }
                )
            else:
                st.info("Nenhum currículo cadastrado ainda.")
    else:
        st.info("Suas vagas não possuem IDs válidos.")
