import 'package:app/l10n/app_localizations.dart';
import 'package:commons/commons.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:service/service.dart';

import '../../../data/model/menu_model.dart';
import '../../../routing/routes.dart';
import 'dashboard_viewmodel.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key, required this.viewModel});

  final DashboardViewmodel viewModel;

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.menuCommand.addListener(_onResult);
  }

  @override
  void didUpdateWidget(covariant DashboardView oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.menuCommand.removeListener(_onResult);
    widget.viewModel.menuCommand.addListener(_onResult);
  }

  @override
  void dispose() {
    widget.viewModel.menuCommand.removeListener(_onResult);
    super.dispose();
  }

  void _onResult() {
    if (widget.viewModel.menuCommand.error) {
      String msgError = kDefaultAppError;

      final commandResult = widget.viewModel.menuCommand.result;
      if (commandResult case Error(error: final exception)) {
        if (exception is HandledException) {
          msgError = exception.message;
        } else if (exception is HttpServiceException) {
          msgError = exception.message ?? exception.toString();
        } else {
          msgError = exception.toString();
        }
      }

      DialogBottomSheetWarning(
        dialogWarning: DialogWarning(
          title: AppLocalizations.of(context).translate('error'),
          titleButtonPrimary: AppLocalizations.of(context).translate('ok'),
          titleButtonSecondary: AppLocalizations.of(context).translate('ok'),
          isDismissible: false,
          typeButtonsDialog: DialogBottomSheetTypeButtons.horizontalButtons,
          description: AppLocalizations.of(context).translate(msgError),
          statusDialog: DialogBottomSheetStatus.statusCritical,
          onPressedPrimary: () => context.pop(),
          onPressedSecondary: () => context.pop(),
        ),
      ).showModal(context);

      widget.viewModel.menuCommand.clearResult();
    } else if (widget.viewModel.menuCommand.completed) {
      // widget.viewModel.statusCoreBankingCommand.clearResult();
      // redirect
    }
  }

  Widget _screen() {
    if (widget.viewModel.menuCommand.running) {
      return const Loading();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        elevation: 0,
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const Center(child: Text('Dashboard')),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('Menu', style: Theme.of(context).textTheme.headlineSmall),
                ),
              ),
              Expanded(child: _menuContents()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuContents() {
    final command = widget.viewModel.menuCommand;
    if (command.running || (!command.completed && !command.error)) {
      return const Center(child: CircularProgressIndicator());
    }
    if (command.error) {
      return ListTile(
        leading: const Icon(Icons.refresh),
        title: Text(AppLocalizations.of(context).translate('erroGeral')),
        onTap: command.execute,
      );
    }

    return ListView(
      padding: EdgeInsets.zero,
      children: [for (final item in widget.viewModel.menuModel.menu) _menuTile(item)],
    );
  }

  Widget _menuTile(Menu item) {
    final route = _routeForMenuKey(item.menuChave);
    final children = item.children ?? const <Menu>[];
    final icon = _iconForMenu(item.menuIcone);

    if (children.isNotEmpty) {
      return ExpansionTile(
        key: PageStorageKey<int>(item.menuId),
        leading: Icon(icon),
        title: Text(item.menuNome),
        trailing: route == null
            ? null
            : IconButton(
                tooltip: item.menuNome,
                icon: const Icon(Icons.arrow_forward),
                onPressed: () => _navigateTo(route),
              ),
        children: [for (final child in children) _menuTile(child)],
      );
    }

    return ListTile(
      leading: Icon(icon),
      title: Text(item.menuNome),
      enabled: route != null,
      onTap: route == null ? null : () => _navigateTo(route),
    );
  }

  String? _routeForMenuKey(String key) {
    final normalizedKey = key.trim().toLowerCase();
    const routesByKey = {
      'home': Routes.home,
      Routes.home: Routes.home,
      'login': Routes.login,
      Routes.login: Routes.login,
      'registro': Routes.registro,
      Routes.registro: Routes.registro,
      'dashboard': Routes.dashboard,
      Routes.dashboard: Routes.dashboard,
    };
    return routesByKey[normalizedKey];
  }

  IconData _iconForMenu(String name) {
    return switch (name.trim().toLowerCase()) {
      'home' => Icons.home_outlined,
      'dashboard' => Icons.dashboard_outlined,
      'login' => Icons.login,
      'registro' || 'person' || 'account' => Icons.person_outline,
      'configuracao' || 'configurações' || 'settings' => Icons.settings_outlined,
      'relatorio' || 'relatórios' || 'report' => Icons.insert_chart_outlined,
      _ => Icons.circle_outlined,
    };
  }

  void _navigateTo(String route) {
    Navigator.of(context).pop();
    context.go(route);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(listenable: widget.viewModel, builder: (context, child) => _screen());
  }
}
