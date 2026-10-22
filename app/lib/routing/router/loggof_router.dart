import 'package:app/features/loggof/ui/loggof_view.dart';
import 'package:app/features/loggof/ui/loggof_viewmodel.dart';
import 'package:go_router/go_router.dart';

import '../routes.dart';

class LoggofRouter {
  static Set<GoRoute> get routes => {
    GoRoute(
      path: Routes.loggof,
      builder: (context, state) => LoggofView(viewModel: LoggofViewmodel()),
    ),
  };
}
