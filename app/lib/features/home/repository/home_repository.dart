import 'package:commons/api_core.dart';
import 'package:commons/result.dart';
import 'package:service/api/dio_provider.dart';
import 'package:service/api/enum.dart';

import '../../../data/model/cep_model.dart';

class HomeRepository {
  Future<Result<CepModel>> get(String cep) async {
    try {
      String parameter = '/$cep/json/';

      final response = await DioProvider.of(ApiCore.cep).request(verb: Verb.get, pathParam: parameter);
      switch (response) {
        case Ok(value: final value) when value is Map:
          return Result.ok(CepModel.fromJson(Map<String, dynamic>.from(value)));
        case Error(error: final error):
          return Result.error(error);
        default:
          return Result.error(Exception('Resposta da API em formato inválido.'));
      }
    } catch (ex) {
      return Result.error(ex is Exception ? ex : Exception(ex.toString()));
    }
  }
}
