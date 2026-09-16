import 'package:provider/provider.dart';

import '../features/access/ui/login_viewmodel.dart';
import '../features/home/ui/home_viewmodel.dart';
import 'dependencies.dart';

List<ChangeNotifierProvider<dynamic>> configProviders() => [
  ChangeNotifierProvider<HomeViewmodel>.value(value: locator<HomeViewmodel>()),
  ChangeNotifierProvider<LoginViewmodel>.value(value: locator<LoginViewmodel>()),
];
