import 'package:app/features/about/ui/about_view.dart';
import 'package:app/features/access/ui/login_view.dart';
import 'package:app/features/access/ui/login_viewmodel.dart';
import 'package:app/features/home/ui/home_view.dart';
import 'package:app/features/home/ui/home_viewmodel.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
        final viewModel = context.read<HomeViewmodel>();
        return HomeView(viewModel: viewModel);
      },
    ),

    GoRoute(
      path: Routes.login,
      builder: (context, state) {
        final viewModel = context.read<LoginViewmodel>();
        return LoginView(viewModel: viewModel);
      },
    ),
  ],
);
