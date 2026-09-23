import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../features/about/ui/about_view.dart';
import '../features/access/ui/login_view.dart';
import '../features/access/ui/login_viewmodel.dart';
import '../features/home/ui/home_view.dart';
import '../features/home/ui/home_viewmodel.dart';
import '../features/tree_view/tree_view_view.dart';
import '../features/tree_view/tree_view_viewmodel.dart';
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

    GoRoute(
      path: Routes.treeView,
      builder: (context, state) {
        final viewModel = context.read<TreeViewViewmodel>();
        return TreeViewView(viewModel: viewModel);
      },
    ),
  ],
);
