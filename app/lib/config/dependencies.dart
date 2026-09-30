import 'package:app/features/access/ui/register_viewmodel.dart';
import 'package:get_it/get_it.dart';

import '../features/access/ui/login_viewmodel.dart';
import '../features/home/repository/home_repository.dart';
import '../features/home/ui/home_viewmodel.dart';
import '../features/home/use_case/home_usecase.dart';
import '../features/traducao/repository/traducao_repository.dart';

final GetIt locator = GetIt.instance;

void configDependencies() {
  locator.registerLazySingleton<HomeRepository>(() => HomeRepository());
  locator.registerLazySingleton<TraducaoRepository>(() => TraducaoRepository());
  locator.registerLazySingleton<HomeUseCase>(
    () => HomeUseCase(locator<HomeRepository>(), locator<TraducaoRepository>()),
  );
  locator.registerFactory<HomeViewmodel>(() => HomeViewmodel(locator<HomeUseCase>()));
  locator.registerFactory<LoginViewmodel>(() => LoginViewmodel());
  locator.registerFactory<RegisterViewmodel>(() => RegisterViewmodel());
}
