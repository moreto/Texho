import '../repository/{{name.snakeCase()}}_repository.dart';

class {{name.pascalCase()}}UseCase {
  {{name.pascalCase()}}UseCase({required this.repository});

  final {{name.pascalCase()}}Repository repository;
}
