import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:service/service.dart';

import '../../../config/command.dart';
import '../../../data/model/access/access_body_model.dart';
import '../use_case/access_usecase.dart';

class LoginViewmodel extends ChangeNotifier {
  LoginViewmodel({required this._accessUseCase}) {
    Log.print(super.runtimeType);
  }

  final AccessUseCase _accessUseCase;

  final TextEditingController email = TextEditingController(text: 'mmoreto@msn.com');
  final TextEditingController password = TextEditingController(text: '123');

  late final Command0 loginCommand = Command0(_login);

  Future<Result<bool>> _login() async {
    notifyListeners();

    String encrypted = await Encrypt().encryptString(password.text, kCryptKeyB64);
    Log.print(encrypted);

    AccessBodyModel accessBodyModel = AccessBodyModel(email: email.text, senha: encrypted);
    final useCaseResult = await _accessUseCase.login(accessBodyModel);
    switch (useCaseResult) {
      case Ok<bool>():
        Log.print(useCaseResult.value.toString(), name: 'Texho', title: 'Sucesso');
        break;

      case Error<bool>():
        if (useCaseResult.error is HttpServiceException) {
          final exception = useCaseResult.error;
          String msgError = exception is HttpServiceException
              ? exception.message ?? exception.toString()
              : exception.toString();

          Log.print(msgError, name: 'Texho', title: 'Erro');
        }
    }

    notifyListeners();

    return useCaseResult;
  }
}
