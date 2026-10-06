import 'package:provider/provider.dart';

import 'theme_controller.dart';

List<ChangeNotifierProvider<dynamic>> configProviders() => [
  ChangeNotifierProvider<ThemeModeController>(create: (_) => ThemeModeController()),
];
