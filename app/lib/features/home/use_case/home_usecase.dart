import 'package:app/data/model/traducao_model.dart';
import 'package:commons/log.dart';
import 'package:commons/result.dart';

import '../../../data/model/cep_model.dart';
import '../../general/repository/traducao_repository.dart';
import '../repository/home_repository.dart';

class HomeUseCase {
  HomeUseCase({required this._homeRepository, required this._traducaoRepository}) {
    Log.print(super.runtimeType);
  }

  final HomeRepository _homeRepository;
  final TraducaoRepository _traducaoRepository;

  Future<Result<CepModel>> get(String cep) async {
    final serviceResult = await _homeRepository.get(cep);
    switch (serviceResult) {
      case Ok<CepModel>():
        return Result.ok(serviceResult.value);
      case Error<CepModel>():
        return Result.error(serviceResult.error);
    }
  }

  Future<Result<List<TraducaoModel>>> getTraducao() async {
    final serviceResult = await _traducaoRepository.get();
    switch (serviceResult) {
      case Ok<List<TraducaoModel>>(:final value):
        return Result.ok(value);
      case Error<List<TraducaoModel>>(:final error):
        return Result.error(error);
    }
  }
}
