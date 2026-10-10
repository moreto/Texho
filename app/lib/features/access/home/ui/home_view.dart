import 'package:app/features/access/home/ui/home_viewmodel.dart';
import 'package:app/routing/routes.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../config/app_config.dart';
import '../../../../l10n/app_localizations.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.viewModel});

  final HomeViewmodel viewModel;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedSetting = 0;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(strings.translate('home')), elevation: 0, centerTitle: true),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            context.push(Routes.login);
          },
          child: Text(strings.translate('login')),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedSetting,
        onDestinationSelected: (index) {
          setState(() => _selectedSetting = index);
          _showSetting(index);
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.text_fields), label: strings.translate('Fonte')),
          NavigationDestination(icon: Icon(Icons.palette_outlined), label: strings.translate('Tema')),
          NavigationDestination(icon: Icon(Icons.language), label: strings.translate('Idioma')),
        ],
      ),
    );
  }

  void _showSetting(int index) {
    final strings = AppLocalizations.of(context);
    final title = switch (index) {
      0 => strings.translate('Fonte'),
      1 => strings.translate('Tema'),
      _ => strings.translate('Idioma'),
    };

    showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            if (index == 0) _fontControl(context),
            if (index == 1) _themeControl(context),
            if (index == 2) _localeControl(context),
          ],
        ),
      ),
    );
  }

  Widget _fontControl(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return DropdownButtonFormField<AppFont>(
      initialValue: context.watch<AppConfig>().font,
      decoration: InputDecoration(labelText: strings.translate('Fonte')),
      items: [for (final font in AppFont.values) DropdownMenuItem(value: font, child: Text(font.label))],
      onChanged: (font) {
        if (font != null) context.read<AppConfig>().setFont(font);
      },
    );
  }

  Widget _themeControl(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return SegmentedButton<ThemeMode>(
      expandedInsets: EdgeInsets.zero,
      segments: [
        ButtonSegment(
          value: ThemeMode.system,
          icon: Icon(Icons.brightness_auto_outlined),
          label: Text(strings.translate('Sistema')),
        ),
        ButtonSegment(
          value: ThemeMode.light,
          icon: Icon(Icons.light_mode_outlined),
          label: Text(strings.translate('Claro')),
        ),
        ButtonSegment(
          value: ThemeMode.dark,
          icon: Icon(Icons.dark_mode_outlined),
          label: Text(strings.translate('Escuro')),
        ),
      ],
      selected: {context.watch<AppConfig>().mode},
      onSelectionChanged: (selection) {
        context.read<AppConfig>().setMode(selection.first);
      },
    );
  }

  Widget _localeControl(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return DropdownButtonFormField<Locale?>(
      initialValue: context.watch<AppConfig>().locale,
      decoration: InputDecoration(labelText: strings.translate('Idioma')),
      items: [
        DropdownMenuItem(value: null, child: Text(strings.translate('Sistema'))),
        DropdownMenuItem(value: Locale('pt', 'BR'), child: Text('Português')),
        DropdownMenuItem(value: Locale('es', 'ES'), child: Text('Español')),
        DropdownMenuItem(value: Locale('en', 'US'), child: Text('English')),
      ],
      onChanged: context.read<AppConfig>().setLocale,
    );
  }
}
