import 'package:commons/commons.dart';

import '../repository/empresa_vinculo_repository.dart';

class EmpresaVinculoUseCase {
  EmpresaVinculoUseCase({required this.repository}) {
    Log.print(super.runtimeType);
  }

  final EmpresaVinculoRepository repository;

  Future<Result<void>> vincular(String codigo) async {
    final normalizedCode = codigo.trim();
    if (normalizedCode.isEmpty) {
      return Result.error(Exception('codigoObrigatorio'));
    }
    return repository.vincular(normalizedCode);
  }
}
