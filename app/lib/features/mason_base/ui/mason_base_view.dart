import 'package:flutter/material.dart';

import 'mason_base_viewmodel.dart';

class MasonBaseView extends StatelessWidget {
  const MasonBaseView({super.key, required this.viewModel});

  final MasonBaseViewmodel viewModel;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Mason Base')),
    body: AnimatedBuilder(
      animation: viewModel,
      builder: (context, _) => const Center(child: Text('Mason Base')),
    ),
  );
}
