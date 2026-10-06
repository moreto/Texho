import 'package:app/config/dependencies.dart';
import 'package:app/features/access/ui/register_view.dart';
import 'package:app/features/access/ui/register_viewmodel.dart';
import 'package:app/features/access/use_case/access_usecase.dart';
import 'package:app/features/general/repository/traducao_repository.dart';
import 'package:app/features/home/repository/home_repository.dart';
import 'package:app/features/home/use_case/home_usecase.dart';
import 'package:go_router/go_router.dart';

import '../features/access/repository/access_repository.dart';
import '../features/access/ui/login_view.dart';
import '../features/access/ui/login_viewmodel.dart';
import '../features/home/ui/home_view.dart';
import '../features/home/ui/home_viewmodel.dart';
import 'routes.dart';

GoRouter router() => GoRouter(
  initialLocation: Routes.home,
  // debugLogDiagnostics: true,
  // redirect: _redirect,
  // refreshListenable: authRepository,

  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) {
        final viewModel = HomeViewmodel(
          homeUseCase: HomeUseCase(
            homeRepository: locator<HomeRepository>(),
            traducaoRepository: locator<TraducaoRepository>(),
          ),
        );
        return HomeView(viewModel: viewModel);
      },
    ),

    GoRoute(
      path: Routes.login,
      builder: (context, state) {
        final viewModel = LoginViewmodel();
        return LoginView(viewModel: viewModel);
      },
    ),

    GoRoute(
      path: Routes.registro,
      builder: (context, state) {
        final viewModel = RegisterViewmodel(
          accessUseCase: AccessUseCase(accessRepository: locator<AccessRepository>()),
        );
        return RegisterView(viewModel: viewModel);
      },
    ),
  ],
);
