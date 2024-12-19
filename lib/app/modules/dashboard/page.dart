import 'package:app_hortifruti_pratico/app/modules/dashboard/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: const Key('DashboardPageScaffold'),
        appBar: AppBar(title: const Text('DashboardPage')),
        bottomNavigationBar: Obx(
          () => NavigationBar(
            onDestinationSelected: controller.changePageIndex,
            selectedIndex: controller.currentPageIndex.value,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.explore_outlined),
                label: 'Inicio',
                selectedIcon: Icon(Icons.explore),
              ),
              NavigationDestination(
                icon: Icon(Icons.explore_outlined),
                label: 'Meu Perfil',
                selectedIcon: Icon(Icons.explore),
              ),
              NavigationDestination(
                icon: Icon(Icons.explore_outlined),
                label: 'Meus Pedidos',
                selectedIcon: Icon(Icons.explore),
              ),
            ],
          ),
        ),
        body: Obx(() => IndexedStack(
              index: controller.currentPageIndex.value,
              children: const [
                Text('Inicio'),
                Text('Meu Perfil'),
                Text('Meus Pedidos'),
              ],
            )));
  }
}
