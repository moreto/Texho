import 'package:commons/commons.dart';

import '../../../data/model/empresa/empresa_usuario_model.dart';
import '../repository/empresa_usuario_repository.dart';

class EmpresaUsuarioUseCase {
  EmpresaUsuarioUseCase({required this.empresaUsuarioRepository}) {
    Log.print(super.runtimeType);
  }

  final EmpresaUsuarioRepository empresaUsuarioRepository;

  Future<Result<List<EmpresaUsuarioModel>>> getUsuarios() async {
    final result = await empresaUsuarioRepository.getUsuarios();
    switch (result) {
      case Ok<List<EmpresaUsuarioModel>>():
        return Result.ok(result.value);
      case Error<List<EmpresaUsuarioModel>>():
        return Result.error(result.error);
    }
  }
}
