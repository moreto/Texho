import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:service/api/service_exception.dart';

import '../../../../config/command.dart';
import '../../../../data/model/access/access_body_model.dart';
import '../use_case/access_usecase.dart';

class LoginViewmodel extends ChangeNotifier {
  LoginViewmodel({required this._accessUseCase}) {
    Log.print(super.runtimeType);
  }

  final AccessUseCase _accessUseCase;

  final TextEditingController email = TextEditingController(text: 'mmoreto@gmail.com');
  final TextEditingController password = TextEditingController(text: '123');
  final TextEditingController otp = TextEditingController();

  late final Command0<bool> loginCommand = Command0(_login);
  late final Command0<bool> requestOtpCommand = Command0(_requestOtp);
  late final Command0<bool> verifyOtpCommand = Command0(_verifyOtp);
  late bool _loginResult;
  bool get loginResult => _loginResult;
  bool _otpRequested = false;
  bool get otpRequested => _otpRequested;

  Future<Result<bool>> _login() async {
    notifyListeners();

    String encrypted = await Encrypt().encryptString(password.text, kCryptKeyB64);

    AccessBodyModel accessBodyModel = AccessBodyModel(email: email.text, senha: encrypted);
    final useCaseResult = await _accessUseCase.login(accessBodyModel);
    switch (useCaseResult) {
      case Ok<bool>():
        _loginResult = useCaseResult.value;
        break;

      case Error<bool>(error: final exception):
        if (exception is HandledException) {
          Log.print(exception.message, name: kApp, title: 'Erro');
        } else if (exception is HttpServiceException) {
          Log.print(exception.message ?? exception.toString(), name: kApp, title: 'Erro');
        } else {
          Log.print(exception.toString(), name: kApp, title: 'Erro');
        }
    }

    notifyListeners();

    return useCaseResult;
  }

  Future<Result<bool>> _requestOtp() async {
    notifyListeners();
    final result = await _accessUseCase.requestOtp(email.text.trim());
    if (result case Ok<bool>(value: true)) {
      _otpRequested = true;
      otp.clear();
    }
    notifyListeners();
    return result;
  }

  Future<Result<bool>> _verifyOtp() async {
    notifyListeners();
    final result = await _accessUseCase.verifyOtp(email.text.trim(), otp.text.trim());
    if (result case Ok<bool>(value: true)) {
      _loginResult = true;
    }
    notifyListeners();
    return result;
  }

  void resetOtpFlow() {
    _otpRequested = false;
    otp.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    otp.dispose();
    loginCommand.dispose();
    requestOtpCommand.dispose();
    verifyOtpCommand.dispose();
    super.dispose();
  }
}
