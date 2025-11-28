import streamlit as st

from utils.data_io import load_vagas, get_vaga_by_id, load_curriculos_by_candidato, add_candidatura, check_candidatura_exists, calcular_score_curriculo, load_curriculos
from utils.ui import ensure_session_defaults

st.set_page_config(page_title="Vagas Abertas", page_icon="📋", layout="wide")

ensure_session_defaults()

st.title("Vagas Abertas")
st.page_link("app.py", label="Voltar para a página inicial", icon="🏠")

vagas_df = load_vagas()

if vagas_df.empty:
    st.info("Nenhuma vaga cadastrada ainda.")
    st.stop()

# Verificar colunas disponíveis e criar opções de filtro
col_estado = "estado" if "estado" in vagas_df.columns else None
col_tipo = "tipo_contratacao" if "tipo_contratacao" in vagas_df.columns else None
col_empresa = "empresa" if "empresa" in vagas_df.columns else None
col_skills = "skills" if "skills" in vagas_df.columns else None

with st.form("filtro_vagas"):
    col1, col2, col3 = st.columns(3)
    with col1:
        if col_estado:
            estados = st.multiselect("Estados", sorted(vagas_df[col_estado].dropna().unique()))
        else:
            estados = []
    with col2:
        if col_tipo:
            tipos = st.multiselect("Tipos de contratação", sorted(vagas_df[col_tipo].dropna().unique()))
        else:
            tipos = []
    with col3:
        if col_empresa:
            empresas = st.multiselect("Empresas", sorted(vagas_df[col_empresa].dropna().unique()))
        else:
            empresas = []
    skill_busca = st.text_input("Filtrar por skill específica")
    aplicar_filtro = st.form_submit_button("Aplicar filtros")

if aplicar_filtro:
    filtrado = vagas_df.copy()
    if estados and col_estado:
        filtrado = filtrado[filtrado[col_estado].isin(estados)]
    if tipos and col_tipo:
        filtrado = filtrado[filtrado[col_tipo].isin(tipos)]
    if empresas and col_empresa:
        filtrado = filtrado[filtrado[col_empresa].isin(empresas)]
    if skill_busca and col_skills:
        filtrado = filtrado[filtrado[col_skills].str.contains(skill_busca, case=False, na=False)]
    vagas_exibir = filtrado
else:
    vagas_exibir = vagas_df

st.dataframe(vagas_exibir, width="stretch")

# Seção de detalhes e candidatura
st.divider()
st.subheader("Detalhes da Vaga e Candidatura")

if "id" in vagas_exibir.columns:
    vaga_ids = vagas_exibir["id"].tolist()
    vaga_selecionada_id = st.selectbox(
        "Selecione uma vaga para ver detalhes e candidatos compatíveis",
        vaga_ids,
        format_func=lambda x: f"{vagas_exibir[vagas_exibir['id'] == x]['titulo'].iloc[0]} - {x}" if "titulo" in vagas_exibir.columns else x
    )
    
    if vaga_selecionada_id:
        vaga = vagas_exibir[vagas_exibir["id"] == vaga_selecionada_id].iloc[0].to_dict()
        
        # Mostrar detalhes da vaga
        col1, col2 = st.columns([2, 1])
        with col1:
            st.markdown(f"### {vaga.get('titulo', 'Sem título')}")
            st.markdown(f"**Empresa:** {vaga.get('empresa', 'N/A')}")
            st.markdown(f"**Localização:** {vaga.get('cidade', 'N/A')}, {vaga.get('estado', 'N/A')}")
            st.markdown(f"**Tipo:** {vaga.get('tipo_contratacao', 'N/A')}")
            st.markdown(f"**Salário:** {vaga.get('salario', 'N/A')}")
            st.markdown(f"**Descrição:** {vaga.get('descricao', 'N/A')}")
            st.markdown(f"**Skills requeridas:** {vaga.get('skills', 'N/A')}")
        
        with col2:
            # Botão de candidatura (apenas para candidatos logados)
            if st.session_state.authenticated and st.session_state.perfil == "candidato":
                st.info("💼 Candidatar-se a esta vaga")
                
                # Verificar se já se candidatou
                ja_candidatou = check_candidatura_exists(vaga_selecionada_id, st.session_state.username)
                
                if ja_candidatou:
                    st.success("✓ Você já se candidatou a esta vaga")
                else:
                    # Listar currículos do candidato
                    meus_curriculos = load_curriculos_by_candidato(st.session_state.username)
                    
                    if meus_curriculos.empty:
                        st.warning("Você precisa cadastrar um currículo primeiro")
                        st.page_link("pages/4_Candidato_-_Cadastro_de_Curriculo.py", label="Cadastrar currículo", icon="📝")
                    else:
                        curriculo_id = st.selectbox(
                            "Escolha o currículo para candidatura",
                            meus_curriculos["id"].tolist() if "id" in meus_curriculos.columns else []
                        )
                        
                        if st.button("Candidatar-se", type="primary"):
                            try:
                                add_candidatura(vaga_selecionada_id, st.session_state.username, curriculo_id)
                                st.success("Candidatura enviada com sucesso!")
                                st.rerun()
                            except ValueError as e:
                                st.error(str(e))
            elif not st.session_state.authenticated:
                st.info("Faça login como candidato para se candidatar")
        
        # Mostrar melhores currículos para esta vaga (apenas para empregadores e admins)
        if st.session_state.authenticated and st.session_state.perfil in ["empregador", "administrador"]:
            st.divider()
            st.subheader("📊 Melhores Currículos para esta Vaga")
            
            todos_curriculos = load_curriculos()
            if not todos_curriculos.empty:
                # Calcular scores
                curriculos_com_score = []
                for _, curriculo in todos_curriculos.iterrows():
                    score = calcular_score_curriculo(curriculo.to_dict(), vaga)
                    curriculos_com_score.append({
                        **curriculo.to_dict(),
                        "score_compatibilidade": score
                    })
                
                # Ordenar por score
                import pandas as pd
                curriculos_ranking = pd.DataFrame(curriculos_com_score)
                curriculos_ranking = curriculos_ranking.sort_values("score_compatibilidade", ascending=False)
                
                # Mostrar top 10
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
    st.info("Selecione uma vaga acima para ver detalhes")
