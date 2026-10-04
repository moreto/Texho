import 'package:app/features/teste_feat/repository/teste_feat_repository.dart';
import 'package:app/features/teste_feat/ui/teste_feat_view.dart';
import 'package:app/features/teste_feat/ui/teste_feat_viewmodel.dart';
import 'package:app/features/teste_feat/use_case/teste_feat_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the Teste Feat screen', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TesteFeatView(
          viewModel: TesteFeatViewmodel(
            useCase: TesteFeatUseCase(repository: TesteFeatRepository()),
          ),
        ),
      ),
    );

    expect(find.text('Teste Feat'), findsNWidgets(2));
  });
}
