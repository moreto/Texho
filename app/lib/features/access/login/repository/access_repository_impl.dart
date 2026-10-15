import 'package:app/data/model/access/access_body_model.dart';
import 'package:app/data/model/access/access_model.dart';
import 'package:app/data/model/usuario/usuario_dispositivo_body_model.dart';
import 'package:app/features/access/login/repository/access_repository.dart';
import 'package:commons/api_core.dart';
import 'package:commons/commons.dart';
import 'package:service/api/dio_provider.dart';
import 'package:service/api/enum.dart';

import '../../../../data/model/access/logn_model.dart';
import '../../../../data/model/usuario/usuario_detalhe_model.dart';
import '../../../../data/model/usuario/usuario_dispositivo_model.dart';

class AccessRepositoryImpl implements AccessRepository {
  @override
  Future<Result<AccessModel>> register(AccessBodyModel model) async {
    try {
      final response = await DioProvider.of(ApiCore.register).request(verb: Verb.post, body: model.toJson());
      switch (response) {
        case Ok():
          AccessModel accessModel = AccessModel.fromJson(Map<String, dynamic>.from(response.value));
          return Result.ok(accessModel);
        case Error():
          return Result.error(response.error);
      }
    } catch (ex) {
      return Result.error(ex is HandledException ? ex : HandledException(message: ex.toString()));
    }
  }

  @override
  Future<Result<LoginModel>> login(AccessBodyModel model) async {
    try {
      final response = await DioProvider.of(ApiCore.login).request(verb: Verb.post, body: model.toJson());
      switch (response) {
        case Ok(value: final value):
          final loginModel = _parseLoginModel(value);
          _setLoggedUser(loginModel, emprId: _emprIdFromResponse(value));
          return Result.ok(loginModel);
        case Error():
          return Result.error(response.error);
      }
    } catch (ex) {
      return Result.error(ex is HandledException ? ex : HandledException(message: ex.toString()));
    }
  }

  @override
  Future<Result<UsuarioDetalheModel>> usuarioDetalheById() async {
    try {
      final response = await DioProvider.of(ApiCore.usuarioDetalheById).request(verb: Verb.get);
      switch (response) {
        case Ok():
          final model = UsuarioDetalheModel.fromJson(Map<String, dynamic>.from(response.value));
          _setEmpresa(model.emprId);
          return Result.ok(model);
        case Error():
          return Result.error(response.error);
      }
    } catch (ex) {
      return Result.error(ex is HandledException ? ex : HandledException(message: ex.toString()));
    }
  }

  @override
  Future<Result<UsuarioDispositivoModel>> usuarioDispositivo(UsuarioDispositivoBodyModel model) async {
    try {
      final response = await DioProvider.of(ApiCore.usuarioDispositivo).request(verb: Verb.post, body: model.toJson());
      switch (response) {
        case Ok():
          final model = UsuarioDispositivoModel.fromJson(Map<String, dynamic>.from(response.value));
          return Result.ok(model);
        case Error():
          return Result.error(response.error);
      }
    } catch (ex) {
      return Result.error(ex is HandledException ? ex : HandledException(message: ex.toString()));
    }
  }

  @override
  Future<Result<bool>> requestOtp(String email) async {
    try {
      final response = await DioProvider.of(ApiCore.requestOtp).request(verb: Verb.post, body: {'email': email});
      switch (response) {
        case Ok():
          return Result.ok(true);
        case Error():
          return Result.error(response.error);
      }
    } catch (error) {
      return Result.error(error is Exception ? error : Exception(error.toString()));
    }
  }

  @override
  Future<Result<bool>> verifyOtp(String email, String otp) async {
    try {
      final response = await DioProvider.of(ApiCore.verifyOtp)
          .request(verb: Verb.post, body: {'email': email, 'otp': otp});
      switch (response) {
        case Ok(value: final value):
          final loginModel = _parseLoginModel(value);
          _setLoggedUser(loginModel, emprId: _emprIdFromResponse(value));
          return Result.ok(true);
        case Error():
          return Result.error(response.error);
      }
    } catch (error) {
      return Result.error(error is Exception ? error : Exception(error.toString()));
    }
  }

  LoginModel _parseLoginModel(dynamic response) {
    if (response is! Map) {
      throw const FormatException('tokenInvalido');
    }

    final loginModel = LoginModel.fromJson(Map<String, dynamic>.from(response));
    if (loginModel.token.isEmpty || loginModel.usuaId <= 0) {
      throw const FormatException('tokenInvalido');
    }

    return loginModel;
  }

  int? _emprIdFromResponse(dynamic response) {
    if (response is Map && response['emprId'] is int) {
      return response['emprId'] as int;
    }
    return null;
  }

  void _setLoggedUser(LoginModel loginModel, {int? emprId}) {
    AuthSession.instance.setLoggedUser(token: loginModel.token, userId: loginModel.usuaId, emprId: emprId);
  }

  void _setEmpresa(int emprId) {
    AuthSession.instance.setEmpresa(emprId: emprId);
  }
}
