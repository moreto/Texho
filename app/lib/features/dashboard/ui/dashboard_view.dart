import 'package:app/config/icons_map.dart';
import 'package:flutter/material.dart';

import 'dashboard_viewmodel.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key, required this.viewModel});

  final DashboardViewmodel viewModel;

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class QuickMenuItem {
  final String title;
  final IconData icon;

  const QuickMenuItem({required this.title, required this.icon});
}

class _DashboardViewState extends State<DashboardView> {
  int currentIndex = 0;

  void _showHorizontalMenu({required String title, required List<QuickMenuItem> items}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 150,
          child: Column(
            children: [
              Text(title),

              const SizedBox(height: 20),

              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 14),
                  itemBuilder: (context, index) {
                    final item = items[index];

                    return QuickCard(
                      title: item.title,
                      icon: item.icon,
                      onTap: () {
                        Navigator.pop(context);

                        ScaffoldMessenger.of(this.context)
                            .showSnackBar(SnackBar(content: Text('Selecionado: ${item.title}')));
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

  void _showBuscarMenu() {
    _showHorizontalMenu(
      title: 'Buscar',
      items: const [
        QuickMenuItem(title: 'Pesquisa', icon: Icons.search),
        QuickMenuItem(title: 'Clientes', icon: Icons.people),
        QuickMenuItem(title: 'Pedidos', icon: Icons.shopping_cart),
        QuickMenuItem(title: 'Produtos', icon: Icons.inventory),
        QuickMenuItem(title: 'Scanner', icon: Icons.qr_code_scanner),
        QuickMenuItem(title: 'Notas', icon: Icons.receipt_long),
      ],
    );
  }

  void _showMaisMenu() {
    _showHorizontalMenu(
      title: 'Ações Rápidas',
      items: const [
        QuickMenuItem(title: 'Novo Pedido', icon: Icons.shopping_cart),
        QuickMenuItem(title: 'Cliente', icon: Icons.person_add),
        QuickMenuItem(title: 'Produto', icon: Icons.inventory_2),
        QuickMenuItem(title: 'Financeiro', icon: Icons.attach_money),
        QuickMenuItem(title: 'Entrega', icon: Icons.local_shipping),
        QuickMenuItem(title: 'Relatórios', icon: Icons.bar_chart),
        QuickMenuItem(title: 'Suporte', icon: Icons.support_agent),
      ],
    );
  }

  void _showFavoritosMenu() {
    _showHorizontalMenu(
      title: 'Favoritos',
      items: const [
        QuickMenuItem(title: 'Clientes', icon: Icons.favorite),
        QuickMenuItem(title: 'Produtos', icon: Icons.star),
        QuickMenuItem(title: 'Pedidos', icon: Icons.bookmark),
        QuickMenuItem(title: 'Consultas', icon: Icons.history),
        QuickMenuItem(title: 'Relatórios', icon: Icons.analytics),
      ],
    );
  }

  void _showPerfilMenu() {
    _showHorizontalMenu(
      title: 'Minha Conta',
      items: const [
        QuickMenuItem(title: 'Perfil', icon: Icons.person),
        QuickMenuItem(title: 'Dados', icon: Icons.badge),
        QuickMenuItem(title: 'Segurança', icon: Icons.lock),
        QuickMenuItem(title: 'Notificações', icon: Icons.notifications),
        QuickMenuItem(title: 'Configurações', icon: Icons.settings),
        QuickMenuItem(title: 'Sair', icon: Icons.logout),
      ],
    );
  }

  Widget _buildHomePage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(IconsMap.mdiIcons['home']!), const SizedBox(height: 20), const Text('Home')],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu Moderno')),
      body: _buildHomePage(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          if (index == 0) {
            setState(() {
              currentIndex = 0;
            });
          } else if (index == 1) {
            _showBuscarMenu();
          } else if (index == 2) {
            _showMaisMenu();
          } else if (index == 3) {
            _showFavoritosMenu();
          } else if (index == 4) {
            _showPerfilMenu();
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Buscar'),
          NavigationDestination(icon: Icon(Icons.add_circle), label: 'Mais'),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}

class QuickCard extends StatelessWidget {
  final String title;
  final IconData icon;
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
                Icon(icon),
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
