---
name: commons-kiss
description: "Crie e mantenha testes unitários Dart/Flutter para lógica nova ou alterada; use ao testar funções, classes, serviços ou corrigir bugs. Exija 100% de cobertura no código de produção dentro do escopo."
---

# Testes unitários com cobertura total

Crie testes que comprovem o comportamento da lógica de produção e atinjam **100% de cobertura executável** no código sob teste. Não declare a tarefa concluída sem executar os testes e conferir o relatório de cobertura.

## Procedimento

1. Leia a implementação, as dependências e os testes próximos. Identifique o contrato público, os caminhos condicionais, limites, erros e efeitos colaterais relevantes.
2. Crie ou atualize testes em `test/`, espelhando a estrutura de `lib/` e usando o sufixo `_test.dart`. Use `flutter_test` em pacotes Flutter e `package:test` em pacotes Dart puros.
3. Escreva casos independentes para todos os caminhos executáveis: entradas válidas e inválidas, limites, opções, resultados vazios/nulos quando aplicável, exceções e fluxos assíncronos. Use fakes ou mocks somente para dependências externas e verifique efeitos colaterais importantes.
4. Mantenha os testes determinísticos: não dependa de rede, relógio real, estado compartilhado ou serviços externos. Injete essas dependências ou substitua-as por doubles de teste.
5. Execute o arquivo de teste e depois a suíte do pacote. Para Flutter, gere cobertura com:

   ```bash
   flutter test --coverage
   ```

   Para Dart puro, use o runner definido pelo pacote e gere o relatório LCOV com a ferramenta de cobertura já adotada no projeto.
6. Confira `coverage/lcov.info` para cada arquivo de produção no escopo: todas as linhas executáveis devem ter contagem maior que zero e a cobertura deve ser **100%**. Quando o relatório fornecer dados de branches ou funções, exija também 100% neles.
7. Se houver linhas ou caminhos descobertos, adicione testes para cobri-los. Se a lógica não puder ser exercitada isoladamente, refatore-a para permitir dependências controláveis, sem alterar o comportamento público.
8. Formate os arquivos Dart e execute a análise estática relevante. Informe o comando executado e o resultado de cobertura.

## Regras de cobertura

- Considere todo o código executável de produção relacionado à funcionalidade como escopo; não reduza o escopo para obter um percentual maior.
- Não use diretivas `coverage:ignore` nem exclua arquivos para mascarar código sem teste. Só aceite exclusões para código gerado ou não executável reconhecido pelo projeto, e deixe a justificativa explícita.
- Cobertura de linhas não prova, por si só, que todos os ramos condicionais foram testados. Cubra cada decisão e valide branches/funções quando disponíveis no relatório.
- Se 100% não for atingido, não afirme que os testes estão completos: informe arquivos, linhas ou branches pendentes e o motivo.
