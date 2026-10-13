import 'package:commons/commons.dart';

import '../../../data/healt_model.dart';

abstract class EmpresaRepository {
  Future<Result<HealtModel>> healt();
}
