import 'package:get_it/get_it.dart';

import '../features/access/home/repository/home_repository.dart';
import '../features/access/login/repository/access_repository.dart';
import '../features/access/login/repository/access_repository_impl.dart';
import '../features/dashboard/repository/dashboard_repository.dart';
import '../features/dashboard/repository/dashboard_repository_impl.dart';
import '../l10n/traducao_repository.dart';
import '../l10n/traducao_repository_impl.dart';

final GetIt locator = GetIt.instance;

void configDependencies() {
  locator.registerLazySingleton<HomeRepository>(() => HomeRepository());
  locator.registerLazySingleton<TraducaoRepository>(() => TraducaoRepositoryImpl());
  locator.registerLazySingleton<AccessRepository>(() => AccessRepositoryImpl());
  locator.registerLazySingleton<DashboardRepository>(() => DashboardRepositoryImpl());
}
