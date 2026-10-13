import 'package:app/features/empresa/repository/empresa_repository.dart';
import 'package:app/features/empresa/ui/empresa_view.dart';
import 'package:app/features/empresa/ui/empresa_viewmodel.dart';
import 'package:app/features/empresa/use_case/empresa_usecase.dart';
import 'package:app/data/healt_model.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeEmpresaRepository implements EmpresaRepository {
  @override
  Future<Result<HealtModel>> healt() async => Result.ok(
    HealtModel(name: 'test', description: '', version: '', host: '', email: ''),
  );
}

void main() {
  testWidgets('shows the Empresa screen', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EmpresaView(
          viewModel: EmpresaViewmodel(
            useCase: EmpresaUseCase(repository: _FakeEmpresaRepository()),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Empresa'), findsNWidgets(2));
  });
}
