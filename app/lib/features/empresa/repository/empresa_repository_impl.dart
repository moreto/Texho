import 'package:commons/api_core.dart';
import 'package:commons/commons.dart';
import 'package:service/service.dart';

import '../../../data/model/empresa/empresa_body_model.dart';
import '../../../data/model/empresa/empresa_model.dart';
import 'empresa_repository.dart';

class EmpresaRepositoryImpl implements EmpresaRepository {
  @override
  Future<Result<EmpresaModel?>> getEmpresa() async {
    try {
      final response = await DioProvider.of(ApiCore.empresa).request(verb: Verb.get);
      switch (response) {
        case Ok(value: null):
          return const Result.ok(null);
        case Ok(value: final value) when value is Map:
          return Result.ok(EmpresaModel.fromJson(Map<String, dynamic>.from(value)));
        case Error(error: final error):
          return Result.error(error);
        default:
          return Result.error(HandledException(message: 'erroApi'));
      }
    } catch (error) {
      return Result.error(error is Exception ? error : Exception(error.toString()));
    }
  }

  @override
  Future<Result<EmpresaModel>> postEmpresa(EmpresaBodyModel model) async {
    try {
      final response = await DioProvider.of(ApiCore.empresa).request(verb: Verb.post, body: model.toJson());
      switch (response) {
        case Ok(value: final value) when value is Map:
          return Result.ok(EmpresaModel.fromJson(Map<String, dynamic>.from(value)));
        case Error(error: final error):
          return Result.error(error);
        default:
          return Result.error(HandledException(message: 'erroApi'));
      }
    } catch (error) {
      return Result.error(error is Exception ? error : Exception(error.toString()));
    }
  }

  @override
  Future<Result<EmpresaModel>> putEmpresa(EmpresaModel model) async {
    try {
      final response = await DioProvider.of(ApiCore.empresa).request(verb: Verb.put, body: model.toJson());
      switch (response) {
        case Ok(value: final value) when value is Map:
          return Result.ok(EmpresaModel.fromJson(Map<String, dynamic>.from(value)));
        case Error(error: final error):
          return Result.error(error);
        default:
          return Result.error(HandledException(message: 'erroApi'));
      }
    } catch (error) {
      return Result.error(error is Exception ? error : Exception(error.toString()));
    }
  }
}
