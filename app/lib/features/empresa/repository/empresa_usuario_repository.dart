import 'package:commons/commons.dart';

import '../../../data/model/healt_model.dart';

abstract class EmpresaUsuarioRepository {
  Future<Result<HealtModel>> healt();
}
