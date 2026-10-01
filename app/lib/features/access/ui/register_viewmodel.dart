import 'package:app/data/model/access/access_body_model.dart';
import 'package:app/data/model/access/access_model.dart';
import 'package:app/features/access/use_case/access_usecase.dart';
import 'package:commons/log.dart';
import 'package:commons/result.dart';
import 'package:flutter/material.dart';

import '../../../config/command.dart';

class RegisterViewmodel extends ChangeNotifier {
  RegisterViewmodel(AccessUseCase accessUseCase) : _accessUseCase = accessUseCase {
    Log.print(super.runtimeType);
  }

  final AccessUseCase _accessUseCase;
  final TextEditingController email = TextEditingController(text: 'mmoreto@gmail.com');
  final TextEditingController password = TextEditingController(text: '123');
  final TextEditingController confirmPassword = TextEditingController(text: '123');

  late final Command0 registerCommand = Command0(_register);

  Future<Result<AccessModel>> _register() async {
    notifyListeners();

    AccessBodyModel accessBodyModel = AccessBodyModel(email: email.text, senha: password.text);

    final useCaseResult = await _accessUseCase.register(accessBodyModel);

    switch (useCaseResult) {
      case Ok<AccessModel>():
        Log.print(useCaseResult.value.toJson(), name: 'Texho', title: 'Sucesso');
        break;

      case Error<AccessModel>(:final error):
        Log.print(error, name: 'Texho', title: 'Erro');
    }

    notifyListeners();

    return useCaseResult;
  }
}
