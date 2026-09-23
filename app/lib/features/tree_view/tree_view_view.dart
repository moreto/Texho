import 'package:flutter/material.dart';

import 'tree_view_viewmodel.dart';

class TreeViewView extends StatefulWidget {
  const TreeViewView({super.key, required this.viewModel});

  final TreeViewViewmodel viewModel;

  @override
  State<TreeViewView> createState() => _TreeViewViewState();
}

class _TreeViewViewState extends State<TreeViewView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Column(children: [

        ],
      ),
    );
  }
}
