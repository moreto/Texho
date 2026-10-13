import 'package:commons/commons.dart';

import '../../../data/model/healt_model.dart';
import '../repository/empresa_repository.dart';

class EmpresaUseCase {
  EmpresaUseCase({required this.empresaRepository}) {
    Log.print(super.runtimeType);
  }

  final EmpresaRepository empresaRepository;

  Future<Result<HealtModel>> healt() async {
    final result = await empresaRepository.healt();
    switch (result) {
      case Ok<HealtModel>():
        return Result.ok(result.value);
      case Error<HealtModel>():
        return Result.error(result.error);
    }
  }
}
