import 'package:provider/provider.dart';

import 'app_config_controller.dart';

List<ChangeNotifierProvider<dynamic>> configProviders() => [
  ChangeNotifierProvider<AppConfigController>(create: (_) => AppConfigController()),
];
