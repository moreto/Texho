import 'package:commons/commons.dart';

import '../../../data/healt_model.dart';
import '../repository/{{name.snakeCase()}}_repository.dart';

class {{name.pascalCase()}}UseCase {
  {{name.pascalCase()}}UseCase({required this.{{name.snakeCase()}}Repository}) {
    Log.print(super.runtimeType);
  }

  final {{name.pascalCase()}}Repository {{name.snakeCase()}}Repository;

  Future<Result<HealtModel>> healt() async {
    final result = await {{name.snakeCase()}}Repository.healt();
    switch (result) {
      case Ok<HealtModel>():
        return Result.ok(result.value);
      case Error<HealtModel>():
        return Result.error(result.error);
    }
  }
}
