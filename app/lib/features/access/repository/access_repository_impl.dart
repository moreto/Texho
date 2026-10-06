import 'package:app/data/model/access/access_body_model.dart';
import 'package:app/data/model/access/access_model.dart';
import 'package:app/features/access/repository/access_repository.dart';
import 'package:commons/commons.dart';
import 'package:service/api/dio_provider.dart';
import 'package:service/api/enum.dart';

class AccessRepositoryImpl implements AccessRepository {
  @override
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

  @override
  Future<Result<bool>> login(AccessBodyModel model) async {
    try {
      final response = await DioProvider.of(ApiCore.login).request(verb: Verb.post, body: model.toJson());
      switch (response) {
        case Ok():
          return Result.ok(response.value);
        case Error():
          return Result.error(response.error);
        // default:
        //   return Result.error(HandledException(message: 'erroApi'));
      }
    } catch (ex) {
      return Result.error(ex is Exception ? ex : Exception(ex.toString()));
    }
  }
}
