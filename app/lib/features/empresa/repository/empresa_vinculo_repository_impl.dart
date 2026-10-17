import 'package:commons/commons.dart';
import 'package:service/service.dart';

import 'empresa_vinculo_repository.dart';

class EmpresaVinculoRepositoryImpl implements EmpresaVinculoRepository {
  @override
  Future<Result<void>> vincular(String codigo) async {
    try {
      final response = await DioProvider.of(ApiCore.empresaUsuarioVincular).request(
        verb: Verb.post,
        body: {'empr_codigo': codigo},
      );
      switch (response) {
        case Ok():
          return const Result.ok(null);
        case Error(error: final error):
          return Result.error(error);
      }
    } catch (error) {
      return Result.error(error is Exception ? error : Exception(error.toString()));
    }
  }
}
