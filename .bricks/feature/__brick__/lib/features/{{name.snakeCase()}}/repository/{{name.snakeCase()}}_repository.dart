import 'package:commons/commons.dart';

import '../../../data/healt_model.dart';

abstract class {{name.pascalCase()}}Repository {
  Future<Result<HealtModel>> healt();
}
