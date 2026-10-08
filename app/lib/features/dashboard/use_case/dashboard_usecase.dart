import 'package:commons/commons.dart';

import '../../../data/model/healt_model.dart';
import '../../../data/model/menu_model.dart';
import '../../../data/repository/menu_repository.dart';
import '../repository/dashboard_repository.dart';

class DashboardUseCase {
  DashboardUseCase({required this.dashboardRepository, required this.menuRepository}) {
    Log.print(super.runtimeType);
  }

  final DashboardRepository dashboardRepository;
  final MenuRepository menuRepository;

  Future<Result<HealtModel>> healt() async {
    final result = await dashboardRepository.healt();
    switch (result) {
      case Ok<HealtModel>():
        return Result.ok(result.value);
      case Error<HealtModel>():
        return Result.error(result.error);
    }
  }

  Future<Result<MenuModel>> menu() async {
    final result = await menuRepository.menu();
    switch (result) {
      case Ok<MenuModel>():
        return Result.ok(result.value);
      case Error<MenuModel>():
        return Result.error(result.error);
    }
  }
}
