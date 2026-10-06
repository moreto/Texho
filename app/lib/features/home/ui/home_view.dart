import 'package:app/features/home/ui/home_viewmodel.dart';
import 'package:app/routing/routes.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../config/app_config_controller.dart';
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
      appBar: AppBar(title: Text(strings.translate('home')), elevation: 0, centerTitle: true),
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
                      style: ElevatedButton.styleFrom(side: BorderSide.none),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  context.push(Routes.login);
                },
                child: Text(strings.translate('login')),
              ),
              SizedBox(width: 8.0),
              ElevatedButton(
                onPressed: () async {
                  context.push(Routes.teste);
                },
                child: Text(strings.translate('Teste')),
              ),
            ],
          ),
          SafeArea(
            minimum: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<AppFont>(
                  initialValue: context.watch<AppConfigController>().font,
                  decoration: InputDecoration(labelText: strings.translate('Fonte')),
                  items: [for (final font in AppFont.values) DropdownMenuItem(value: font, child: Text(font.label))],
                  onChanged: (font) {
                    if (font != null) context.read<AppConfigController>().setFont(font);
                  },
                ),
                const SizedBox(height: 16),
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
                  selected: {context.watch<AppConfigController>().mode},
                  onSelectionChanged: (selection) {
                    context.read<AppConfigController>().setMode(selection.first);
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<Locale?>(
                  initialValue: context.watch<AppConfigController>().locale,
                  decoration: InputDecoration(labelText: strings.translate('Idioma')),
                  items: [
                    DropdownMenuItem(value: null, child: Text(strings.translate('Sistema'))),
                    DropdownMenuItem(value: Locale('pt', 'BR'), child: Text('Português')),
                    DropdownMenuItem(value: Locale('es', 'ES'), child: Text('Español')),
                    DropdownMenuItem(value: Locale('en', 'US'), child: Text('English')),
                  ],
                  onChanged: context.read<AppConfigController>().setLocale,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
