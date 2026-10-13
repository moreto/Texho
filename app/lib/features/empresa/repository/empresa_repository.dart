import 'package:commons/commons.dart';

import '../../../data/model/empresa/empresa_body_model.dart';

abstract class EmpresaRepository {
  Future<Result<EmpresaModel>> getEmpresa();
}
