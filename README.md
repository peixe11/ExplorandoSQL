Documentação do Banco de Dados para Produção Agrícola

Introdução Este banco de dados foi projetado para organizar informações sobre a produção agrícola no Brasil, incluindo dados sobre culturas, estados, safras e a produtividade de cada uma. Essa estrutura facilita a análise da produção agrícola por cultura e estado ao longo dos anos, apoiando a tomada de decisões estratégicas no setor.

Histórico e Objetivo do Fluxo de Dados

O fluxo de dados começa com a tabela cultura, que armazena diferentes culturas agrícolas, como soja e milho. Em seguida, a tabela estado mantém o registro dos estados onde essas culturas são plantadas. Para cada cultura, em um determinado estado e ano, uma entrada é criada na tabela safra, que armazena o ano da safra e faz referência à cultura e ao estado. Por fim, a tabela producao contém informações detalhadas sobre a produtividade, área plantada e produção total de cada safra.

Este modelo facilita a criação de relatórios e análises temporais e geográficas da produção agrícola no Brasil.

Dicionário de Dados

Tabela: cultura

Descrição: Armazena os diferentes tipos de culturas agrícolas cultivadas.

Campos:

id: Identificador único da cultura. Tipo: NUMBER. Restrição: PRIMARY KEY.

nome: Nome da cultura. Tipo: VARCHAR2(100). Restrição: Único, com chave única un_cultura_nome.

Tabela: estado

Descrição: Armazena os estados onde as culturas agrícolas são plantadas.

Campos:

id: Identificador único do estado. Tipo: NUMBER. Restrição: PRIMARY KEY.

nome: Nome do estado. Tipo: VARCHAR2(100). Restrição: Único, com chave única un_estado_nome.

Tabela: safra

Descrição: Representa cada safra de uma cultura em um estado específico e ano.

Campos:

id: Identificador único da safra. Tipo: NUMBER. Restrição: PRIMARY KEY.

estado_id: Referência ao estado da safra. Tipo: NUMBER. Restrição: FOREIGN KEY para estado(id), com o nome fk_safra_estado.

cultura_id: Referência à cultura da safra. Tipo: NUMBER. Restrição: FOREIGN KEY para cultura(id), com o nome fk_safra_cultura.

ano: Ano da safra. Tipo: NUMBER(4).

Tabela: producao

Descrição: Armazena dados sobre a produtividade, área plantada e produção total de cada safra.

Campos:

id: Identificador único da produção. Tipo: NUMBER. Restrição: PRIMARY KEY.

safra_id: Referência à safra correspondente. Tipo: NUMBER. Restrição: FOREIGN KEY para safra(id), com o nome fk_producao_safra.

produtividade: Produtividade em unidades específicas. Tipo: NUMBER.

area_plantada: Área plantada em hectares. Tipo: NUMBER.

producao_total: Produção total em toneladas. Tipo: NUMBER.