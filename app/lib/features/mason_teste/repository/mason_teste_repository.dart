import 'package:app/data/healt_model.dart';
import 'package:commons/commons.dart';
import 'package:service/service.dart';

class MasonTesteRepository {
    Future<Result<HealtModel>> healt() async {
    try {
      final response = await DioProvider.of(ApiCore.register).request(verb: Verb.get);
      switch (response) {
        case Ok(value: final value) when value is Map:
          return Result.ok(HealtModel.fromJson(Map<String, dynamic>.from(value)));
        case Error(error: final error):
          return Result.error(error);
        default:
          return Result.error(Exception('erroApi')); // TODO Verificar tipo erro...
      }
    } catch (ex) {
      return Result.error(ex is Exception ? ex : Exception(ex.toString()));
    }
  }
}
