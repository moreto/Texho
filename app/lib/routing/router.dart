import 'package:app/routing/router/access_router.dart';
import 'package:app/routing/router/empresa_router.dart';
import 'package:app/routing/router/log_router.dart';
import 'package:app/routing/router/notificacao_router.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';

GoRouter router() => GoRouter(
  initialLocation: Routes.home,
  // debugLogDiagnostics: true,
  // redirect: _redirect,
  // refreshListenable: authRepository,

  routes: [...AccessRouter.routes, ...EmpresaRouter.routes, ...LogRouter.routes, ...NotificacaoRouter.routes],
);
