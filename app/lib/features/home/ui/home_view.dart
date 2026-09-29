import 'package:app/features/home/ui/home_viewmodel.dart';
import 'package:app/routing/routes.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../config/theme_controller.dart';
import '../../../l10n/app_localizations.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.viewModel});

  final HomeViewmodel viewModel;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(strings.translate('home'))),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: widget.viewModel.cepController,
                        decoration: InputDecoration(
                          labelText: strings.translate('CEP'),
                          hintText: strings.translate('Digite o CEP'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () async {
                        await widget.viewModel.cepCommand.execute();
                        await widget.viewModel.traducaoCommand.execute();
                      },
                      child: Text(strings.translate('Busca CEP')),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              context.go(Routes.login);
            },
            child: Text(strings.translate('login')),
          ),
          SafeArea(
            minimum: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<AppFont>(
                  initialValue: context.watch<ThemeModeController>().font,
                  decoration: InputDecoration(labelText: strings.translate('Fonte')),
                  items: [for (final font in AppFont.values) DropdownMenuItem(value: font, child: Text(font.label))],
                  onChanged: (font) {
                    if (font != null) context.read<ThemeModeController>().setFont(font);
                  },
                ),
                const SizedBox(height: 12),
                SegmentedButton<ThemeMode>(
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
                  selected: {context.watch<ThemeModeController>().mode},
                  onSelectionChanged: (selection) {
                    context.read<ThemeModeController>().setMode(selection.first);
                  },
                ),
              ],
            ),
          ),
          SafeArea(
            minimum: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: DropdownButtonFormField<Locale?>(
              initialValue: context.watch<ThemeModeController>().locale,
              decoration: InputDecoration(labelText: strings.translate('Idioma')),
              items: [
                DropdownMenuItem(value: null, child: Text(strings.translate('Sistema'))),
                DropdownMenuItem(value: Locale('pt', 'BR'), child: Text('Português')),
                DropdownMenuItem(value: Locale('es', 'ES'), child: Text('Español')),
                DropdownMenuItem(value: Locale('en', 'US'), child: Text('English')),
              ],
              onChanged: context.read<ThemeModeController>().setLocale,
            ),
          ),
        ],
      ),
    );
  }
}
