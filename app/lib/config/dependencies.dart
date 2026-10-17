import 'package:get_it/get_it.dart';

import '../features/access/home/repository/home_repository.dart';
import '../features/access/login/repository/access_repository.dart';
import '../features/access/login/repository/access_repository_impl.dart';
import '../features/dashboard/repository/dashboard_repository.dart';
import '../features/dashboard/repository/dashboard_repository_impl.dart';
import '../features/empresa/repository/empresa_repository.dart';
import '../features/empresa/repository/empresa_repository_impl.dart';
import '../features/empresa/repository/empresa_usuario_repository.dart';
import '../features/empresa/repository/empresa_usuario_repository_impl.dart';
import '../features/log/repository/log_repository.dart';
import '../features/log/repository/log_repository_impl.dart';
import '../features/notificacao/repository/notificacao_repository.dart';
import '../features/notificacao/repository/notificacao_repository_impl.dart';
import '../l10n/traducao_repository.dart';
import '../l10n/traducao_repository_impl.dart';

final GetIt locator = GetIt.instance;

void configDependencies() {
  locator.registerLazySingleton<HomeRepository>(() => HomeRepository());
  locator.registerLazySingleton<TraducaoRepository>(() => TraducaoRepositoryImpl());
  locator.registerLazySingleton<AccessRepository>(() => AccessRepositoryImpl());
  locator.registerLazySingleton<DashboardRepository>(() => DashboardRepositoryImpl());
  locator.registerLazySingleton<EmpresaRepository>(() => EmpresaRepositoryImpl());
  locator.registerLazySingleton<EmpresaUsuarioRepository>(() => EmpresaUsuarioRepositoryImpl());
  locator.registerLazySingleton<NotificacaoRepository>(() => NotificacaoRepositoryImpl());
  locator.registerLazySingleton<LogRepository>(() => LogRepositoryImpl());
}
