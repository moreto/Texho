import 'package:commons/result.dart';
import 'package:service/api/api_core.dart';
import 'package:service/api/dio_provider.dart';
import 'package:service/api/enum.dart';

import '../../../data/model/cep_model.dart';

class HomeRepository {
  Future<Result<CepModel>> get() async {
    try {
      final response = await DioProvider.of(ApiCore.cep).request(verb: Verb.get);
      switch (response) {
        case Ok<Map<String, dynamic>>():
          return Result.ok(CepModel.fromJson(response.value));
        case Error<Map<String, dynamic>>():
          return Result.error(response.error);
      }
    } catch (ex) {
      return Result.error(ex is Exception ? ex : Exception(ex.toString()));
    }
  }
}
