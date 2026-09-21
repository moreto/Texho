import 'package:commons/log.dart';
import 'package:commons/result.dart';
import 'package:flutter/material.dart';

import '../../../config/command.dart';
import '../../../data/model/cep_model.dart';
import '../use_case/home_usecase.dart';

class HomeViewmodel extends ChangeNotifier {
  HomeViewmodel(HomeUseCase homeUseCase) : _homeUseCase = homeUseCase {
    Log.print(super.runtimeType);
  }
  TextEditingController cepController = TextEditingController(text: '73252200');
  final HomeUseCase _homeUseCase;

  late final Command0 cepCommand = Command0(_get);

  Future<Result<CepModel>> _get() async {
    notifyListeners();
    final useCaseResult = await _homeUseCase.get(cepController.text);

    switch (useCaseResult) {
      case Ok<CepModel>():
        Log.print(useCaseResult.value.toJson(), name: 'Texho', title: 'Sucesso');
        break;

      case Error<CepModel>(:final error):
        Log.print(error, name: 'Texho', title: 'Erro');
    }

    notifyListeners();

    return useCaseResult;
  }
}
