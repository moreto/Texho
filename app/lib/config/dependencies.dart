import 'package:get_it/get_it.dart';

import '../features/access/ui/login_viewmodel.dart';
import '../features/home/repository/home_repository.dart';
import '../features/home/ui/home_viewmodel.dart';
import '../features/home/use_case/home_usecase.dart';

final GetIt locator = GetIt.instance;

void configDependencies() {
  locator.registerLazySingleton<HomeRepository>(() => HomeRepository());
  locator.registerLazySingleton<HomeUseCase>(() => HomeUseCase(locator<HomeRepository>()));
  locator.registerFactory<HomeViewmodel>(() => HomeViewmodel(locator<HomeUseCase>()));
  locator.registerFactory<LoginViewmodel>(() => LoginViewmodel());
}
