import 'package:commons/log.dart';
import 'package:commons/result.dart';

import '../../../data/model/cep_model.dart';
import '../repository/home_repository.dart';

class HomeUseCase {
  HomeUseCase(HomeRepository homeRepository) : _homeRepository = homeRepository {
    Log.print(super.runtimeType);
  }

  final HomeRepository _homeRepository;

  Future<Result<CepModel>> get() async {
    final serviceResult = await _homeRepository.get();
    switch (serviceResult) {
      case Ok<CepModel>():
        return Result.ok(serviceResult.value);
      case Error<CepModel>():
        return Result.error(serviceResult.error);
    }
  }
}
