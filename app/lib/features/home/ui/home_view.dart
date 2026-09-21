import 'package:app/features/home/ui/home_viewmodel.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/theme_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.viewModel});

  final HomeViewmodel viewModel;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
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
                        decoration: InputDecoration(labelText: 'CEP', hintText: 'Digite o CEP'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () async {
                        await widget.viewModel.cepCommand.execute();
                      },
                      child: const Text('Busca CEP'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            minimum: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<AppFont>(
                  initialValue: context.watch<ThemeModeController>().font,
                  decoration: const InputDecoration(labelText: 'Fonte'),
                  items: [for (final font in AppFont.values) DropdownMenuItem(value: font, child: Text(font.label))],
                  onChanged: (font) {
                    if (font != null) context.read<ThemeModeController>().setFont(font);
                  },
                ),
                const SizedBox(height: 12),
                SegmentedButton<ThemeMode>(
                  expandedInsets: EdgeInsets.zero,
                  segments: const [
                    ButtonSegment(
                      value: ThemeMode.system,
                      icon: Icon(Icons.brightness_auto_outlined),
                      label: Text('Sistema'),
                    ),
                    ButtonSegment(value: ThemeMode.light, icon: Icon(Icons.light_mode_outlined), label: Text('Claro')),
                    ButtonSegment(value: ThemeMode.dark, icon: Icon(Icons.dark_mode_outlined), label: Text('Escuro')),
                  ],
                  selected: {context.watch<ThemeModeController>().mode},
                  onSelectionChanged: (selection) {
                    context.read<ThemeModeController>().setMode(selection.first);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
