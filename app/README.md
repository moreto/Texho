# app

MMoreto App

## Gerar uma feature

O brick local em `../.bricks/feature` cria uma estrutura em
`lib/features/<nome>/` com repositório, caso de uso, viewmodel e view, além de
um teste de widget inicial.

Instale o Mason CLI uma vez e, dentro de `app/`, gere a feature:

```sh
dart pub global activate mason_cli
mason get
mason make feature --name user_profile
```

Use o nome em `snake_case`. Após gerar, registre a feature na aplicação:

1. Em `lib/config/dependencies.dart`, registre o repositório e o caso de uso
   como `lazySingleton` e o viewmodel como `factory`.
2. Em `lib/config/providers.dart`, exponha o viewmodel com
   `ChangeNotifierProvider`.
3. Adicione o caminho em `lib/routing/routes.dart` e a rota em
   `lib/routing/router.dart`, obtendo o viewmodel pelo provider.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
