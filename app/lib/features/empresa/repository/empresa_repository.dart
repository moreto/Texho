import 'package:commons/commons.dart';

import '../../../data/model/healt_model.dart';

abstract class EmpresaRepository {
  Future<Result<HealtModel>> healt();
}
