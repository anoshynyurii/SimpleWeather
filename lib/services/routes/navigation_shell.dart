import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const NavShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        onDestinationSelected: (index) =>
            navigationShell.goBranch(index, initialLocation: true),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.cloud_rounded),
            label: 'Головна',
          ),
          NavigationDestination(
            icon: Icon(Icons.show_chart_rounded),
            label: 'Графік',
          ),
          NavigationDestination(
            icon: Icon(Icons.percent_rounded),
            label: 'Статистика',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_rounded),
            label: 'Налаштування',
          ),
        ],
      ),
    );
  }
}
