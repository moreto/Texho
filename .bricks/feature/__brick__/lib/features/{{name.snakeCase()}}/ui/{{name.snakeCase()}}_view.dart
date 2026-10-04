import 'package:flutter/material.dart';

import '{{name.snakeCase()}}_viewmodel.dart';

class {{name.pascalCase()}}View extends StatelessWidget {
  const {{name.pascalCase()}}View({super.key, required this.viewModel});

  final {{name.pascalCase()}}Viewmodel viewModel;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('{{name.titleCase()}}')),
    body: AnimatedBuilder(
      animation: viewModel,
      builder: (context, _) => const Center(child: Text('{{name.titleCase()}}')),
    ),
  );
}
