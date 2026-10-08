import 'package:app/data/model/healt_model.dart';
import 'package:commons/commons.dart';
import 'package:service/service.dart';

import '../../../data/model/menu_model.dart';
import 'dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  @override
  Future<Result<HealtModel>> healt() async {
    try {
      final response = await DioProvider.of(ApiCore.healt).request(verb: Verb.get);
      switch (response) {
        case Ok(value: final value) when value is Map:
          return Result.ok(HealtModel.fromJson(Map<String, dynamic>.from(value)));
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
  Future<Result<MenuModel>> menu() async {
    try {
      final response = await DioProvider.of(ApiCore.menu).request(verb: Verb.get);
      MenuModel model = menuModelFromJson(response as String);
      switch (response) {
        case Ok():
          return Result.ok(model);
        case Error():
          return Result.error(response.error);
      }
    } catch (ex) {
      return Result.error(ex is HandledException ? ex : HandledException(message: ex.toString()));
    }
  }
}
