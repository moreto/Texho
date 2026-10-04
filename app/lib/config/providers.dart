import 'package:app/features/access/ui/register_viewmodel.dart';
import 'package:app/features/mason_teste/ui/mason_teste_viewmodel.dart';
import 'package:provider/provider.dart';

import '../features/access/ui/login_viewmodel.dart';
import '../features/home/ui/home_viewmodel.dart';
import 'dependencies.dart';
import 'theme_controller.dart';

List<ChangeNotifierProvider<dynamic>> configProviders() => [
  ChangeNotifierProvider<ThemeModeController>(create: (_) => ThemeModeController()),
  ChangeNotifierProvider<HomeViewmodel>.value(value: locator<HomeViewmodel>()),
  ChangeNotifierProvider<LoginViewmodel>.value(value: locator<LoginViewmodel>()),
  ChangeNotifierProvider<RegisterViewmodel>.value(value: locator<RegisterViewmodel>()),
  ChangeNotifierProvider<MasonTesteViewmodel>.value(value: locator<MasonTesteViewmodel>()),
];
