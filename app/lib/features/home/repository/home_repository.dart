import 'package:commons/commons.dart';
import 'package:service/service.dart';

import '../../../data/model/cep_model.dart';

class HomeRepository {
  Future<Result<CepModel>> get(String cep) async {
    try {
      String parameter = '/$cep/json/';

      final response = await DioProvider.of(ApiCore.cep).request(verb: Verb.get, pathParam: parameter);
      switch (response) {
        case Ok(value: final value) when value is Map:
          return Result.ok(CepModel.fromJson(Map<String, dynamic>.from(value)));
        case Error<HandledException>():
          return Result.error(response.error);
        case Error<HttpServiceException>():
          return Result.error(response.error);
        default:
          return Result.error(HandledException(message: 'Resposta da API em formato inválido.'));
      }
    } catch (ex) {
      return Result.error(ex is Exception ? ex : Exception(ex.toString()));
    }
  }
}
