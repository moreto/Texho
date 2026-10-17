import 'package:commons/commons.dart';

import '../../../data/model/healt_model.dart';
import '../repository/empresa_usuario_repository.dart';

class EmpresaUsuarioUseCase {
  EmpresaUsuarioUseCase({required this.empresaUsuarioRepository}) {
    Log.print(super.runtimeType);
  }

  final EmpresaUsuarioRepository empresaUsuarioRepository;

  Future<Result<HealtModel>> healt() async {
    final result = await empresaUsuarioRepository.healt();
    switch (result) {
      case Ok<HealtModel>():
        return Result.ok(result.value);
      case Error<HealtModel>():
        return Result.error(result.error);
    }
  }
}
