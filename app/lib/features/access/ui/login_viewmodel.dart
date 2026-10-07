import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:service/api/service_exception.dart';

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
  late bool _loginResult;
  bool get loginResult => _loginResult;

  Future<Result<bool>> _login() async {
    notifyListeners();

    String encrypted = await Encrypt().encryptString(password.text, kCryptKeyB64);
    Log.print(encrypted);

    AccessBodyModel accessBodyModel = AccessBodyModel(email: email.text, senha: encrypted);
    final useCaseResult = await _accessUseCase.login(accessBodyModel);
    switch (useCaseResult) {
      case Ok<bool>():
        _loginResult = useCaseResult.value;
        break;

      case Error<bool>(error: final exception):
        if (exception is HandledException) {
          Log.print(exception.message, name: 'Texho', title: 'Erro');
        } else if (exception is HttpServiceException) {
          Log.print(exception.message ?? exception.toString(), name: 'Texho', title: 'Erro');
        } else {
          Log.print(exception.toString(), name: 'Texho', title: 'Erro');
        }
    }

    notifyListeners();

    return useCaseResult;
  }
}
