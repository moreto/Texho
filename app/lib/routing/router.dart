import 'package:app/config/dependencies.dart';
import 'package:app/features/access/ui/register_view.dart';
import 'package:app/features/access/ui/register_viewmodel.dart';
import 'package:app/features/access/use_case/access_usecase.dart';
import 'package:app/features/general/repository/traducao_repository.dart';
import 'package:app/features/home/repository/home_repository.dart';
import 'package:app/features/home/use_case/home_usecase.dart';
import 'package:app/features/mason_teste/ui/mason_teste_view.dart';
import 'package:app/features/mason_teste/ui/mason_teste_viewmodel.dart';
import 'package:app/features/mason_teste/use_case/mason_teste_usecase.dart';
import 'package:go_router/go_router.dart';

import '../features/about/ui/about_view.dart';
import '../features/access/repository/access_repository.dart';
import '../features/access/ui/login_view.dart';
import '../features/access/ui/login_viewmodel.dart';
import '../features/home/ui/home_view.dart';
import '../features/home/ui/home_viewmodel.dart';
import '../features/mason_teste/repository/mason_teste_repositoy.dart';
import 'routes.dart';

GoRouter router() => GoRouter(
  initialLocation: Routes.home,
  // debugLogDiagnostics: true,
  // redirect: _redirect,
  // refreshListenable: authRepository,
  routes: [
    GoRoute(path: Routes.about, builder: (context, state) => const AboutView()),

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

    //
    GoRoute(
      path: Routes.teste,
      builder: (context, state) {
        // final viewModel = context.read<MasonTesteViewmodel>();
        final viewModel = MasonTesteViewmodel(
          masonTesteUseCase: MasonTesteUseCase(masonTesteRepository: locator<MasonTesteRepository>()),
        );
        return MasonTesteView(viewModel: viewModel);
      },
    ),
  ],
);
