import 'package:app/features/access/ui/register_viewmodel.dart';
import 'package:app/features/general/repository/healt_repository.dart';
import 'package:app/features/mason_teste/repository/mason_teste_repository.dart';
import 'package:app/features/mason_teste/ui/mason_teste_viewmodel.dart';
import 'package:app/features/mason_teste/use_case/mason_teste_usecase.dart';
import 'package:get_it/get_it.dart';

import '../features/access/repository/access_repository.dart';
import '../features/access/ui/login_viewmodel.dart';
import '../features/access/use_case/access_usecase.dart';
import '../features/home/repository/home_repository.dart';
import '../features/home/ui/home_viewmodel.dart';
import '../features/home/use_case/home_usecase.dart';
import '../features/general/repository/traducao_repository.dart';

final GetIt locator = GetIt.instance;

void configDependencies() {
  locator.registerLazySingleton<HomeRepository>(() => HomeRepository());
  locator.registerLazySingleton<TraducaoRepository>(() => TraducaoRepository());
  locator.registerLazySingleton<AccessRepository>(() => AccessRepository());
  locator.registerLazySingleton<HealtRepository>(() => HealtRepository());
  locator.registerLazySingleton<MasonTesteRepository>(() => MasonTesteRepository());

  //
  locator.registerLazySingleton<HomeUseCase>(
    () => HomeUseCase(locator<HomeRepository>(), locator<TraducaoRepository>()),
  );
  locator.registerFactory<AccessUseCase>(() => AccessUseCase(locator<AccessRepository>()));
  locator.registerFactory<MasonTesteUseCase>(
    () => MasonTesteUseCase(locator<MasonTesteRepository>()),
  );
  locator.registerFactory<HomeViewmodel>(() => HomeViewmodel(locator<HomeUseCase>()));
  locator.registerFactory<LoginViewmodel>(() => LoginViewmodel());
  locator.registerFactory<RegisterViewmodel>(() => RegisterViewmodel(locator<AccessUseCase>()));
  locator.registerFactory<MasonTesteViewmodel>(() => MasonTesteViewmodel(locator<MasonTesteUseCase>()));
}
