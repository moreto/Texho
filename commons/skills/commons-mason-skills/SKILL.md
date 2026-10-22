---
name: commons-mason-skills
description: "Use ao criar, ajustar ou refatorar uma tela/feature Flutter neste projeto. Siga a arquitetura e os arquivos do brick Mason .bricks/feature, mantendo UI, Viewmodel, UseCase e Repository organizados e integrados ao app."
---

# Refatorar telas com o padrão Mason Feature

Ao criar ou alterar uma tela no app, siga o padrão do brick [`.bricks/feature`](../../../.bricks/feature/brick.yaml). Preserve o comportamento existente e adapte os exemplos do brick ao domínio real; não replique os placeholders de health.

## Estrutura da feature

Organize o código sob `app/lib/features/<nome_snake_case>/`:

- `ui/<nome>_view.dart`: widgets, apresentação, interação e ciclo de vida da tela.
- `ui/<nome>_viewmodel.dart`: estado e comandos da tela; delegue as operações ao UseCase.
- `use_case/<nome>_usecase.dart`: coordenação da ação da feature e tradução do resultado da operação.
- `repository/<nome>_repository.dart`: contrato da fonte de dados.
- `repository/<nome>_repository_impl.dart`: implementação do contrato e integração com serviços/dados.

Coloque testes em `app/test/features/<nome>/`, espelhando as camadas relevantes e usando os fakes existentes ou doubles determinísticos.

## Fluxo de trabalho

1. Leia a tela, seu Viewmodel, os serviços/dados usados, rotas, registro de dependências, testes e arquivos correspondentes do brick. Mapeie o comportamento atual antes de mover ou alterar lógica.
2. Use nome de feature em `snake_case`. Para uma feature realmente nova, a partir de `app/`, gere o ponto de partida com:

   ```bash
   mason make feature --name nome_da_feature
   ```

   Em uma refatoração, não gere por cima de uma pasta existente: use o brick como referência e integre as mudanças aos arquivos atuais para não sobrescrever código.
3. Separe apresentação, estado, regra de aplicação e acesso a dados nas camadas acima. Mantenha widgets focados na UI; mova lógica de negócio para o UseCase e acesso externo para o Repository.
4. Preserve a API e o comportamento da tela, incluindo estados de carregamento, sucesso, erro, ações, navegação, localização e acessibilidade. Não introduza chamadas de rede ou efeitos colaterais diretamente no widget.
5. Integre a feature às superfícies existentes: registre implementações e dependências em `app/lib/config/dependencies.dart`, conecte View/Viewmodel às rotas e providers usados pelo app e atualize imports e configuração necessários.
6. Trate os arquivos Mason como scaffold, não como implementação pronta: confirme imports, construtores, tipos de resultado e modelos contra o código atual. Remova o comportamento demonstrativo de health e substitua-o pelas operações e modelos reais da feature.
7. Adicione ou atualize testes para Viewmodel, UseCase, Repository e tela conforme o escopo alterado. Cubra estados de carregamento, sucesso, erro, ações do usuário e navegação relevante sem depender de rede ou estado externo.
8. Formate e analise os arquivos Dart alterados. Execute os testes direcionados e, em seguida, os testes relevantes do app; corrija falhas antes de concluir.

## Critérios para concluir

- A tela continua acessível pelas rotas existentes e usa as dependências corretamente registradas.
- O estado e as regras não foram duplicados entre widget, Viewmodel e UseCase.
- As alterações preservam os comportamentos existentes, com testes para os fluxos afetados.
- Informe os comandos de validação executados e quaisquer limitações restantes.
