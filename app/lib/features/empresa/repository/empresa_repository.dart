import 'package:commons/commons.dart';

import '../../../data/model/empresa/empresa_body_model.dart';
import '../../../data/model/empresa/empresa_model.dart';

abstract class EmpresaRepository {
  Future<Result<EmpresaModel?>> getEmpresa();
  Future<Result<EmpresaModel>> postEmpresa(EmpresaBodyModel model);
  Future<Result<EmpresaModel>> putEmpresa(EmpresaModel model);
}
