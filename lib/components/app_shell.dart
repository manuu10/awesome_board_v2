import 'package:awesome_board_v2/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    Key? key,
    required this.mainContent,
  }) : super(key: key);

  final Widget mainContent;

  @override
  Widget build(BuildContext context) {
    final location = GoRouter.of(context).location;
    int index = 1;
    if (location == "/${Routes.create}") index = 0;
    if (location == "/${Routes.settings}") index = 2;
    return Scaffold(
      body: mainContent,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          if (index == 0) Routes.goCreate(context);
          if (index == 1) Routes.goHome(context);
          if (index == 2) Routes.goSettings(context);
        },
        selectedIndex: index,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.add_box_outlined),
            icon: Icon(Icons.add_box),
            label: 'Create',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.dashboard_outlined),
            icon: Icon(Icons.dashboard),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings_outlined),
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
