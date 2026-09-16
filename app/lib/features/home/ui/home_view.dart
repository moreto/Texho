import 'package:app/features/home/ui/home_viewmodel.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Teste...'),
            ElevatedButton(
              onPressed: () async {
                await widget.viewModel.cepCommand.execute();
              },
              child: Text('Get CEP'),
            ),
          ],
        ),
      ),
    );
  }
}
