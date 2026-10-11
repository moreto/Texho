import 'dart:io';

import 'package:app/data/model/usuario/usuario_dispositivo_body_model.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:service/api/service_exception.dart';

import '../../../../config/command.dart';
import '../../../../config/device_info.dart';
import '../../../../config/usuario_session.dart';
import '../../../../data/model/access/access_body_model.dart';
import '../../../../data/model/access/logn_model.dart';
import '../../../../data/model/usuario/usuario_detalhe_model.dart';
import '../../../../data/model/usuario/usuario_dispositivo_model.dart';
import '../use_case/access_usecase.dart';

class LoginViewmodel extends ChangeNotifier {
  LoginViewmodel({required this._accessUseCase}) {
    Log.print(super.runtimeType);
  }

  final AccessUseCase _accessUseCase;
  bool _disposed = false;

  final TextEditingController email = TextEditingController(text: 'mmoreto@gmail.com');
  final TextEditingController password = TextEditingController(text: '123');
  final TextEditingController otp = TextEditingController();

  late final Command0<LoginModel> loginCommand = Command0(_login);

  late final Command0<bool> requestOtpCommand = Command0(_requestOtp);
  late final Command0<bool> verifyOtpCommand = Command0(_verifyOtp);
  late bool _loginResult;
  bool get loginResult => _loginResult;
  bool _otpRequested = false;
  bool get otpRequested => _otpRequested;

  late final Command0<UsuarioDetalheModel> usuarioDetalheCommand = Command0(_usuarioDetalheById);
  UsuarioDetalheModel? get usuarioDetalhe => UsuarioSession.instance.usuarioDetalhe;

  Future<Result<LoginModel>> _login() async {
    _notifyListenersIfNotDisposed();

    String encrypted = await Encrypt().encryptString(password.text, kCryptKeyB64);

    AccessBodyModel accessBodyModel = AccessBodyModel(email: email.text, senha: encrypted);
    final useCaseResult = await _accessUseCase.login(accessBodyModel);
    switch (useCaseResult) {
      case Ok<LoginModel>():
        _loginResult = true;
        _usuarioDispositivo();
        await usuarioDetalheCommand.execute();
        break;

      case Error<LoginModel>(error: final exception):
        if (exception is HandledException) {
          Log.print(exception.message, name: kApp, title: 'Erro');
        } else if (exception is HttpServiceException) {
          Log.print(exception.message ?? exception.toString(), name: kApp, title: 'Erro');
        } else {
          Log.print(exception.toString(), name: kApp, title: 'Erro');
        }
    }

    _notifyListenersIfNotDisposed();

    return useCaseResult;
  }

  Future<Result<UsuarioDetalheModel>> _usuarioDetalheById() async {
    _notifyListenersIfNotDisposed();

    final useCaseResult = await _accessUseCase.usuarioDetalheById();
    switch (useCaseResult) {
      case Ok<UsuarioDetalheModel>():
        UsuarioSession.instance.setUsuarioDetalhe(useCaseResult.value);
        break;
      case Error<UsuarioDetalheModel>(error: final exception):
        if (exception is HandledException) {
          Log.print(exception.message, name: kApp, title: 'Erro');
        } else if (exception is HttpServiceException) {
          Log.print(exception.message ?? exception.toString(), name: kApp, title: 'Erro');
        } else {
          Log.print(exception.toString(), name: kApp, title: 'Erro');
        }
    }

    _notifyListenersIfNotDisposed();

    return useCaseResult;
  }

  Future<Result<UsuarioDispositivoModel>> _usuarioDispositivo() async {
    _notifyListenersIfNotDisposed();

    List<String> ipList = [];
    for (var interface in await NetworkInterface.list()) {
      ipList.add(interface.name);
      // Log.print('== Interface: ${interface.name} ==');
      for (var addr in interface.addresses) {
        ipList.add(addr.address);
        // Log.print('${addr.address} ${addr.host} ${addr.isLoopback} ${addr.rawAddress} ${addr.type.name}');
      }
    }

    UsuarioDispositivoBodyModel model = UsuarioDispositivoBodyModel(
      udisId: 0,
      emprId: AuthSession.instance.emprId ?? 1,
      udisDeviceId: DeviceInfo.instance.deviceId,
      udisNome: DeviceInfo.instance.name,
      udisSistemaOperacional: DeviceInfo.instance.operatingSystem,
      udloIp: ipList.toString(),
    );

    final useCaseResult = await _accessUseCase.usuarioDispositivo(model);

    switch (useCaseResult) {
      case Ok<UsuarioDispositivoModel>():
        break;
      case Error<UsuarioDispositivoModel>(error: final exception):
        if (exception is HandledException) {
          Log.print(exception.message, name: kApp, title: 'Erro');
        } else if (exception is HttpServiceException) {
          Log.print(exception.message ?? exception.toString(), name: kApp, title: 'Erro');
        } else {
          Log.print(exception.toString(), name: kApp, title: 'Erro');
        }
    }

    _notifyListenersIfNotDisposed();

    return useCaseResult;
  }

  Future<Result<bool>> _requestOtp() async {
    _notifyListenersIfNotDisposed();
    final result = await _accessUseCase.requestOtp(email.text.trim());
    if (result case Ok<bool>(value: true)) {
      _otpRequested = true;
      otp.clear();
    }
    _notifyListenersIfNotDisposed();
    return result;
  }

  Future<Result<bool>> _verifyOtp() async {
    _notifyListenersIfNotDisposed();
    final result = await _accessUseCase.verifyOtp(email.text.trim(), otp.text.trim());
    if (result case Ok<bool>(value: true)) {
      _loginResult = true;
    }
    _notifyListenersIfNotDisposed();
    return result;
  }

  void resetOtpFlow() {
    _otpRequested = false;
    otp.clear();
    _notifyListenersIfNotDisposed();
  }

  void _notifyListenersIfNotDisposed() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    email.dispose();
    password.dispose();
    otp.dispose();
    loginCommand.dispose();
    usuarioDetalheCommand.dispose();
    requestOtpCommand.dispose();
    verifyOtpCommand.dispose();
    super.dispose();
  }
}
