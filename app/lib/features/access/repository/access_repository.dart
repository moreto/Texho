import 'package:app/data/model/access/access_body_model.dart';
import 'package:app/data/model/access/access_model.dart';
import 'package:commons/api_core.dart';
import 'package:commons/result.dart';
import 'package:service/api/dio_provider.dart';
import 'package:service/api/enum.dart';

class AccessRepository {
  Future<Result<AccessModel>> register(AccessBodyModel model) async {
    try {
      final response = await DioProvider.of(ApiCore.register).request(verb: Verb.post, body: model.toJson());
      switch (response) {
        case Ok(value: final value) when value is Map:
          return Result.ok(AccessModel.fromJson(Map<String, dynamic>.from(value)));
        case Error(error: final error):
          return Result.error(error);
        default:
          return Result.error(Exception('erroApi'));
      }
    } catch (ex) {
      return Result.error(ex is Exception ? ex : Exception(ex.toString()));
    }
  }
}
