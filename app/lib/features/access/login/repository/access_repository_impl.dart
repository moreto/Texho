import 'package:app/data/model/access/access_body_model.dart';
import 'package:app/data/model/access/access_model.dart';
import 'package:app/features/access/login/repository/access_repository.dart';
import 'package:commons/commons.dart';
import 'package:service/api/dio_provider.dart';
import 'package:service/api/enum.dart';

class AccessRepositoryImpl implements AccessRepository {
  @override
  Future<Result<AccessModel>> register(AccessBodyModel model) async {
    try {
      final response = await DioProvider.of(ApiCore.register).request(verb: Verb.post, body: model.toJson());
      switch (response) {
        case Ok():
          AccessModel accessModel = AccessModel.fromJson(Map<String, dynamic>.from(response.value));
          return Result.ok(accessModel);
        case Error():
          return Result.error(response.error);
      }
    } catch (ex) {
      return Result.error(ex is HandledException ? ex : HandledException(message: ex.toString()));
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
      }
    } catch (ex) {
      return Result.error(ex is HandledException ? ex : HandledException(message: ex.toString()));
    }
  }

  @override
  Future<Result<bool>> requestOtp(String email) async {
    try {
      final response = await DioProvider.of(ApiCore.requestOtp).request(
        verb: Verb.post,
        body: {'email': email},
      );
      switch (response) {
        case Ok():
          return Result.ok(true);
        case Error():
          return Result.error(response.error);
      }
    } catch (error) {
      return Result.error(error is Exception ? error : Exception(error.toString()));
    }
  }

  @override
  Future<Result<bool>> verifyOtp(String email, String otp) async {
    try {
      final response = await DioProvider.of(ApiCore.verifyOtp).request(
        verb: Verb.post,
        body: {'email': email, 'otp': otp},
      );
      switch (response) {
        case Ok(value: final value) when value == true:
          return Result.ok(true);
        case Ok():
          return Result.error(HandledException(message: 'codigoOtpInvalido'));
        case Error():
          return Result.error(response.error);
      }
    } catch (error) {
      return Result.error(error is Exception ? error : Exception(error.toString()));
    }
  }
}
