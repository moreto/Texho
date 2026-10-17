import 'package:app/features/empresa/repository/empresa_usuario_repository.dart';
import 'package:app/features/empresa/ui/empresa_usuario_view.dart';
import 'package:app/features/empresa/ui/empresa_usuario_viewmodel.dart';
import 'package:app/features/empresa/use_case/empresa_usuario_usecase.dart';
import 'package:app/data/healt_model.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeEmpresaUsuarioRepository implements EmpresaUsuarioRepository {
  @override
  Future<Result<HealtModel>> healt() async => Result.ok(
    HealtModel(name: 'test', description: '', version: '', host: '', email: ''),
  );
}

void main() {
  testWidgets('shows the Empresa Usuario screen', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EmpresaUsuarioView(
          viewModel: EmpresaUsuarioViewmodel(
            useCase: EmpresaUsuarioUseCase(repository: _FakeEmpresaUsuarioRepository()),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Empresa Usuario'), findsNWidgets(2));
  });
}
