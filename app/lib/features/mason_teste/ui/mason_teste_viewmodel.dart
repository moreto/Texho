import 'package:app/config/command.dart';
import 'package:app/data/healt_model.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:service/service.dart';

import '../use_case/mason_teste_usecase.dart';

class MasonTesteViewmodel extends ChangeNotifier {
  MasonTesteViewmodel(MasonTesteUseCase masonTesteUseCase) : _masonTesteUseCase = masonTesteUseCase {
    Log.print(super.runtimeType);
    healtCommand.execute();
  }

  final MasonTesteUseCase _masonTesteUseCase;

  late final Command0 healtCommand = Command0(_healt);
  late HealtModel _healtModel;
  HealtModel get healtModel => _healtModel;

  Future<Result<HealtModel>> _healt() async {
    notifyListeners();

    final useCaseResult = await _masonTesteUseCase.healt();
    switch (useCaseResult) {
      case Ok<HealtModel>():
        _healtModel = useCaseResult.value;
        break;

      case Error<HealtModel>():
        if (useCaseResult.error is HttpServiceException) {
          final exception = useCaseResult.error;
          String msgError = exception is HttpServiceException
              ? exception.message ?? exception.toString()
              : exception.toString();
          Log.print(msgError, name: 'Texho', title: 'Erro'); // TODO Verificar erro viewmodel...
        }
    }

    notifyListeners();

    return useCaseResult;
  }
}
