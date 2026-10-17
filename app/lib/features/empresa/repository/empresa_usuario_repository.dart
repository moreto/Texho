import 'package:commons/commons.dart';

import '../../../data/model/empresa/empresa_usuario_model.dart';

abstract class EmpresaUsuarioRepository {
  Future<Result<List<EmpresaUsuarioModel>>> getUsuarios();
}
