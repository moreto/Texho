import 'package:commons/commons.dart';

import '../../../data/healt_model.dart';
import '../repository/{{name.snakeCase()}}_repository.dart';

class {{name.pascalCase()}}UseCase {
  {{name.pascalCase()}}UseCase({required this.repository}) {
    Log.print(super.runtimeType);
  }

  final {{name.pascalCase()}}Repository repository;

  Future<Result<HealtModel>> healt() async {
    final result = await repository.healt();
    switch (result) {
      case Ok<HealtModel>():
        return Result.ok(result.value);
      case Error<HealtModel>():
        return Result.error(result.error);
    }
  }
}
