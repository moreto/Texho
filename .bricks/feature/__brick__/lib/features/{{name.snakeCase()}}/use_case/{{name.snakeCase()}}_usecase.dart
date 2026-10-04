import 'package:commons/commons.dart';

import '../../../data/healt_model.dart';
import '../repository/{{name.snakeCase()}}_repository.dart';

class {{name.pascalCase()}}UseCase {
    {{name.pascalCase()}}UseCase({{name.pascalCase()}}Repository masonTesteRepository) : _masonTesteRepository = masonTesteRepository {
    Log.print(super.runtimeType);
  }

  final {{name.pascalCase()}}Repository repository;




}
