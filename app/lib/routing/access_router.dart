import 'package:app/features/dashboard/repository/dashboard_repository.dart';
import 'package:go_router/go_router.dart';

import '../config/dependencies.dart';
import '../features/access/home/ui/home_view.dart';
import '../features/access/home/ui/home_viewmodel.dart';
import '../features/access/home/use_case/home_usecase.dart';
import '../features/access/login/repository/access_repository.dart';
import '../features/access/login/ui/login_view.dart';
import '../features/access/login/ui/login_viewmodel.dart';
import '../features/access/login/ui/register_view.dart';
import '../features/access/login/ui/register_viewmodel.dart';
import '../features/access/login/use_case/access_usecase.dart';
import '../features/dashboard/ui/dashboard_view.dart';
import '../features/dashboard/ui/dashboard_viewmodel.dart';
import '../features/dashboard/use_case/dashboard_usecase.dart';
import 'routes.dart';

class AccessRouter {
  static Set<GoRoute> get routes => {
    GoRoute(
      path: Routes.home,
      builder: (context, state) {
        final viewModel = HomeViewmodel(homeUseCase: HomeUseCase());
        return HomeView(viewModel: viewModel);
      },
    ),

    GoRoute(
      path: Routes.login,
      builder: (context, state) {
        final viewModel = LoginViewmodel(accessUseCase: AccessUseCase(accessRepository: locator<AccessRepository>()));
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

    GoRoute(
      path: Routes.dashboard,
      builder: (context, state) {
        final viewModel = DashboardViewmodel(
          dashboardUseCase: DashboardUseCase(dashboardRepository: locator<DashboardRepository>()),
        );
        return DashboardView(viewModel: viewModel);
      },
    ),
  };
}
