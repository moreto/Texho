import 'package:app/features/general/repository/healt_repository.dart';
import 'package:app/features/mason_teste/repository/mason_teste_repository.dart';
import 'package:get_it/get_it.dart';

import '../features/access/repository/access_repository.dart';
import '../features/general/repository/traducao_repository.dart';
import '../features/home/repository/home_repository.dart';

final GetIt locator = GetIt.instance;

void configDependencies() {
  locator.registerLazySingleton<HomeRepository>(() => HomeRepository());
  locator.registerLazySingleton<TraducaoRepository>(() => TraducaoRepository());
  locator.registerLazySingleton<AccessRepository>(() => AccessRepository());
  locator.registerLazySingleton<HealtRepository>(() => HealtRepository());
  locator.registerLazySingleton<MasonTesteRepository>(() => MasonTesteRepository());
}
