import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/providers.dart';
import 'routing/router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: configProviders(),
      child: MaterialApp.router(
        // scrollBehavior: AppCustomScrollBehavior(),
        // theme: MmTheme.lightTheme,
        // darkTheme: MmTheme.darkTheme,
        // themeMode: ThemeMode.system,
        routerConfig: router(),
        // localizationsDelegates: AppLocalizations.localizationsDelegates,
        // supportedLocales: AppLocalizations.supportedLocales,
        // locale: localeModel.locale,
      ),
    );
  }
}
