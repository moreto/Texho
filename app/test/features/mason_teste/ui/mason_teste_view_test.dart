import 'package:app/features/mason_teste/repository/mason_teste_repository.dart';
import 'package:app/features/mason_teste/ui/mason_teste_view.dart';
import 'package:app/features/mason_teste/ui/mason_teste_viewmodel.dart';
import 'package:app/features/mason_teste/use_case/mason_teste_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the Mason Teste screen', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MasonTesteView(
          viewModel: MasonTesteViewmodel(
            useCase: MasonTesteUseCase(repository: MasonTesteRepository()),
          ),
        ),
      ),
    );

    expect(find.text('Mason Teste'), findsNWidgets(2));
  });
}
