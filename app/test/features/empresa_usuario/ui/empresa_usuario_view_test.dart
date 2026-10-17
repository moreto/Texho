import 'package:app/features/empresa/repository/empresa_vinculo_repository.dart';
import 'package:app/features/empresa/ui/empresa_usuario_view.dart';
import 'package:app/features/empresa/ui/empresa_vinculo_viewmodel.dart';
import 'package:app/features/empresa/use_case/empresa_vinculo_usecase.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeEmpresaVinculoRepository implements EmpresaVinculoRepository {
  String? codigoVinculado;

  @override
  Future<Result<void>> vincular(String codigo) async {
    codigoVinculado = codigo;
    return const Result.ok(null);
  }
}

void main() {
  testWidgets('links the current user using the company code', (tester) async {
    final repository = _FakeEmpresaVinculoRepository();
    final viewModel = EmpresaVinculoViewmodel(useCase: EmpresaVinculoUseCase(repository: repository));

    await tester.pumpWidget(MaterialApp(home: EmpresaUsuarioView(viewModel: viewModel)));

    expect(find.text('Vincular-se a uma empresa'), findsOneWidget);
    expect(find.text('Nome da empresa'), findsNothing);

    await tester.enterText(find.byType(TextFormField), '  ABC123  ');
    await tester.tap(find.text('Vincular'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(repository.codigoVinculado, 'ABC123');
    expect(find.text('Vinculação à empresa realizada com sucesso.'), findsOneWidget);
  });

  testWidgets('requires a company code before submitting', (tester) async {
    final repository = _FakeEmpresaVinculoRepository();
    final viewModel = EmpresaVinculoViewmodel(useCase: EmpresaVinculoUseCase(repository: repository));

    await tester.pumpWidget(MaterialApp(home: EmpresaUsuarioView(viewModel: viewModel)));
    await tester.tap(find.text('Vincular'));
    await tester.pump();

    expect(find.text('Informe o código da empresa.'), findsOneWidget);
    expect(repository.codigoVinculado, isNull);
  });
}
