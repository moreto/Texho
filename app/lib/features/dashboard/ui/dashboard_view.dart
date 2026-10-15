import 'package:app/config/icons_map.dart';
import 'package:app/data/model/menu_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'dashboard_viewmodel.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key, required this.viewModel});

  final DashboardViewmodel viewModel;

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _currentIndex = 0;

  void _selectMenu(Menu menu, int index) {
    setState(() => _currentIndex = index);

    final children = menu.children ?? const [];
    if (children.isNotEmpty) {
      _showSubmenu(menu, children);
      return;
    }

    _navigateTo(menu);
  }

  void _showSubmenu(Menu parent, List<Menu> children) {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return SizedBox(
          height: 150,
          child: Column(
            children: [
              Text(parent.menuNome),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: children.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 14),
                  itemBuilder: (context, index) {
                    final child = children[index];
                    return QuickCard(
                      title: child.menuNome,
                      icon: _iconFor(child),
                      onTap: () {
                        Navigator.pop(sheetContext);
                        _navigateTo(child);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _navigateTo(Menu menu) {
    final route = menu.menuRota;
    if (route == null && route == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Rota não definida para ${menu.menuNome}')));
      return;
    } else {
      context.push(route!);
    }
  }

  Icon _iconFor(Menu menu) {
    final icon = IconsMap.mdiIcons[menu.menuIcone];
    if (icon == null) {
      return const Icon(Icons.error_outline);
    }
    return Icon(icon);
  }

  Widget _buildMenu(MenuModel menuModel) {
    final menus = menuModel.menu;
    if (menus.isEmpty) {
      return const Scaffold(body: Center(child: Text('Nenhum menu disponível')));
    }

    final selectedIndex = _currentIndex < menus.length ? _currentIndex : 0;
    final selectedMenu = menus[selectedIndex];

    return Scaffold(
      appBar: AppBar(title: Text(selectedMenu.menuNome)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_iconFor(selectedMenu), const SizedBox(height: 20), Text(selectedMenu.menuNome)],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) => _selectMenu(menus[index], index),
        destinations: [
          for (final menu in menus)
            NavigationDestination(icon: _iconFor(menu), selectedIcon: _iconFor(menu), label: menu.menuNome),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, child) {
        final menuModel = widget.viewModel.menuModel;
        if (menuModel != null) {
          return _buildMenu(menuModel);
        }

        if (widget.viewModel.menuCommand.running) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Não foi possível carregar o menu'),
                const SizedBox(height: 16),
                FilledButton(onPressed: widget.viewModel.menuCommand.execute, child: const Text('Tentar novamente')),
              ],
            ),
          ),
        );
      },
    );
  }
}

class QuickCard extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback onTap;

  const QuickCard({super.key, required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 145,
      child: Card(
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(height: 14),
                Text(title, textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
