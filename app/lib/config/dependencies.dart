import 'package:app/l10n/traducao_repository_impl.dart';
import 'package:get_it/get_it.dart';

import '../features/access/repository/access_repository.dart';
import '../features/access/repository/access_repository_impl.dart';
import '../features/access/home/repository/home_repository.dart';
import '../l10n/traducao_repository.dart';

final GetIt locator = GetIt.instance;

void configDependencies() {
  locator.registerLazySingleton<HomeRepository>(() => HomeRepository());
  locator.registerLazySingleton<TraducaoRepository>(() => TraducaoRepositoryImpl());
  locator.registerLazySingleton<AccessRepository>(() => AccessRepositoryImpl());
}
