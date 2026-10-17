import 'package:commons/commons.dart';
import 'package:service/service.dart';

import '../../../data/model/empresa/empresa_usuario_model.dart';
import 'empresa_usuario_repository.dart';

class EmpresaUsuarioRepositoryImpl implements EmpresaUsuarioRepository {
  @override
  Future<Result<List<EmpresaUsuarioModel>>> getUsuarios() async {
    try {
      final response = await DioProvider.of(ApiCore.empresaUsuarioDetalhe).request(verb: Verb.get);
      switch (response) {
        case Ok(value: final value) when value is List:
          return Result.ok(
            value
                .map((item) {
                  if (item is! Map) {
                    throw const FormatException('Formato de usuário da empresa inválido.');
                  }
                  return EmpresaUsuarioModel.fromJson(Map<String, dynamic>.from(item));
                })
                .toList(growable: false),
          );
        case Error(error: final error):
          return Result.error(error);
        default:
          return Result.error(HandledException(message: 'Formato de resposta da API inválido.'));
      }
    } catch (error) {
      return Result.error(error is Exception ? error : Exception(error.toString()));
    }
  }
}
