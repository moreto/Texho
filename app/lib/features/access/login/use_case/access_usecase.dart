import 'package:app/data/model/access/access_body_model.dart';
import 'package:app/data/model/access/access_model.dart';
import 'package:commons/log.dart';
import 'package:commons/result.dart';

import '../../../../data/model/usuario/usuario_detalhe_model.dart';
import '../repository/access_repository.dart';

class AccessUseCase {
  AccessUseCase({required this._accessRepository}) {
    Log.print(super.runtimeType);
  }

  final AccessRepository _accessRepository;

  Future<Result<AccessModel>> register(AccessBodyModel model) async {
    final serviceResult = await _accessRepository.register(model);
    switch (serviceResult) {
      case Ok<AccessModel>():
        return Result.ok(serviceResult.value);
      case Error<AccessModel>():
        return Result.error(serviceResult.error);
    }
  }

  Future<Result<bool>> login(AccessBodyModel model) async {
    final serviceResult = await _accessRepository.login(model);
    switch (serviceResult) {
      case Ok<bool>():
        return Result.ok(serviceResult.value);
      case Error<bool>():
        return Result.error(serviceResult.error);
    }
  }

  Future<Result<bool>> requestOtp(String email) => _accessRepository.requestOtp(email);

  Future<Result<bool>> verifyOtp(String email, String otp) => _accessRepository.verifyOtp(email, otp);

  Future<Result<UsuarioDetalheModel>> usuarioDetalheById() async {
    final serviceResult = await _accessRepository.usuarioDetalheById();
    switch (serviceResult) {
      case Ok<UsuarioDetalheModel>():
        return Result.ok(serviceResult.value);
      case Error<UsuarioDetalheModel>():
        return Result.error(serviceResult.error);
    }
  }
}
