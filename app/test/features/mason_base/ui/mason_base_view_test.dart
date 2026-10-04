import 'package:app/features/mason_base/repository/mason_base_repository.dart';
import 'package:app/features/mason_base/ui/mason_base_view.dart';
import 'package:app/features/mason_base/ui/mason_base_viewmodel.dart';
import 'package:app/features/mason_base/use_case/mason_base_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the Mason Base screen', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MasonBaseView(
          viewModel: MasonBaseViewmodel(
            useCase: MasonBaseUseCase(repository: MasonBaseRepository()),
          ),
        ),
      ),
    );

    expect(find.text('Mason Base'), findsNWidgets(2));
  });
}
