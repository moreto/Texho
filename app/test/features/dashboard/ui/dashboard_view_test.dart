import 'package:app/data/model/healt_model.dart';
import 'package:app/data/model/menu_model.dart';
import 'package:app/features/dashboard/repository/dashboard_repository.dart';
import 'package:app/features/dashboard/ui/dashboard_view.dart';
import 'package:app/features/dashboard/ui/dashboard_viewmodel.dart';
import 'package:app/features/dashboard/use_case/dashboard_usecase.dart';
import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeDashboardRepository implements DashboardRepository {
  @override
  Future<Result<HealtModel>> healt() async =>
      Result.ok(HealtModel(name: 'test', description: '', version: '', host: '', email: ''));

  @override
  Future<Result<MenuModel>> menu() async => Result.ok(
    MenuModel(
      menu: [
        Menu(
          menuId: 1,
          menuNome: 'Cadastros',
          menuChave: 'cadastros',
          menuIcone: 'folder',
          menuSequencia: 1,
          children: [
            Menu(menuId: 2, menuNome: 'Clientes', menuChave: 'clientes', menuIcone: 'person', menuSequencia: 1),
          ],
        ),
      ],
    ),
  );
}

void main() {
  testWidgets('shows menu items and children in the navigation drawer', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DashboardView(
          viewModel: DashboardViewmodel(
            dashboardUseCase: DashboardUseCase(dashboardRepository: _FakeDashboardRepository()),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Dashboard'), findsNWidgets(2));
    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();

    expect(find.text('Cadastros'), findsOneWidget);
    expect(find.text('Clientes'), findsNothing);

    await tester.tap(find.text('Cadastros'));
    await tester.pumpAndSettle();

    expect(find.text('Clientes'), findsOneWidget);
  });
}
