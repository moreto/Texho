import 'package:app/data/model/empresa/empresa_usuario_model.dart';
import 'package:app/features/empresa/repository/empresa_usuario_repository.dart';
import 'package:app/features/empresa/ui/empresa_usuario_view.dart';
import 'package:app/features/empresa/ui/empresa_usuario_viewmodel.dart';
import 'package:app/features/empresa/use_case/empresa_usuario_usecase.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeEmpresaUsuarioRepository implements EmpresaUsuarioRepository {
  @override
  Future<Result<List<EmpresaUsuarioModel>>> getUsuarios() async => const Result.ok([]);
}

void main() {
  testWidgets('shows the company users screen', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EmpresaUsuarioView(
          viewModel: EmpresaUsuarioViewmodel(
            empresaUsuarioUseCase: EmpresaUsuarioUseCase(empresaUsuarioRepository: _FakeEmpresaUsuarioRepository()),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Usuários da empresa'), findsOneWidget);
    expect(find.text('Nenhum usuário vinculado à empresa.'), findsOneWidget);
  });
}
