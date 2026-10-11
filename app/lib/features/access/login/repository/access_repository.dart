import 'package:commons/commons.dart';

import '../../../../data/model/access/access_body_model.dart';
import '../../../../data/model/access/access_model.dart';
import '../../../../data/model/access/logn_model.dart';
import '../../../../data/model/usuario/usuario_detalhe_model.dart';
import '../../../../data/model/usuario/usuario_dispositivo_body_model.dart';
import '../../../../data/model/usuario/usuario_dispositivo_model.dart';

abstract class AccessRepository {
  Future<Result<AccessModel>> register(AccessBodyModel model);
  Future<Result<LoginModel>> login(AccessBodyModel model);
  Future<Result<UsuarioDetalheModel>> usuarioDetalheById();
  Future<Result<bool>> requestOtp(String email);
  Future<Result<bool>> verifyOtp(String email, String otp);
  Future<Result<UsuarioDispositivoModel>> usuarioDispositivo(UsuarioDispositivoBodyModel model);
}
