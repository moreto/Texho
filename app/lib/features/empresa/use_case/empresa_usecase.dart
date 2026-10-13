import 'package:commons/commons.dart';

import '../../../data/model/empresa/empresa_body_model.dart';
import '../repository/empresa_repository.dart';

class EmpresaUseCase {
  EmpresaUseCase({required this.empresaRepository}) {
    Log.print(super.runtimeType);
  }

  final EmpresaRepository empresaRepository;

  Future<Result<EmpresaModel>> getEmpresa() async {
    final result = await empresaRepository.getEmpresa();
    switch (result) {
      case Ok<EmpresaModel>():
        return Result.ok(result.value);
      case Error<EmpresaModel>():
        return Result.error(result.error);
    }
  }
}
