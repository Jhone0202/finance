# Finance – Flutter Live Coding Exercise

Este projeto é um exercício prático de **live coding com Flutter**, com foco em boas práticas de desenvolvimento mobile, incluindo:

- **Clean Architecture**
- **Gerenciamento de estado com Provider**
- **Paginação simulada**
- **Tratamento de erros controlado**
- **Testes unitários com cobertura dos fluxos principais**

---

## Objetivo

Simular a construção de uma aplicação mobile simples de controle de transações financeiras. O foco está na organização do código, clareza arquitetural, boas práticas com Flutter/Dart e capacidade de raciocínio técnico ao vivo.

---

## Funcionalidades

- Exibição de uma lista de transações financeiras com status (Aprovada, Pendente, Recusada)
- Filtro por status
- Paginação simulada no carregamento da lista
- Exibição do valor total das transações visíveis
- Tratamento de erros com fallback de mensagem
- Arquitetura desacoplada com interface de repositório (`ITransactionsRepository`)
- Testes unitários da lógica principal (`HomeController`)

---

## Rodando os testes

```bash
flutter test
```

---

## Como executar o projeto

```bash
flutter pub get
flutter run
```

---

## Licença

Este projeto é livre para uso educacional e testes técnicos.
