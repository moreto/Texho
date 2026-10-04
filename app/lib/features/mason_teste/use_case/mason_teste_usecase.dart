import 'package:app/features/mason_teste/repository/mason_teste_repository.dart';
import 'package:commons/commons.dart';

import '../../../data/healt_model.dart';

class MasonTesteUseCase {
  MasonTesteUseCase(this._masonTesteRepository) {
    Log.print(super.runtimeType);
  }

  final MasonTesteRepository _masonTesteRepository;

  Future<Result<HealtModel>> healt() async {
    final serviceResult = await _masonTesteRepository.healt();
    switch (serviceResult) {
      case Ok<HealtModel>():
        return Result.ok(serviceResult.value);
      case Error<HealtModel>():
        return Result.error(serviceResult.error);
    }
  }
}
